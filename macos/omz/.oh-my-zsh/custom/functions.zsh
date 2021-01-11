function broutine() {
    echo "Runnign brew upgrade"
    brew upgrade
    echo "Running brew cleanup"
    brew cleanup
}

function _print_osc() {
    if [[ $TERM == screen* ]]; then
        printf "\033Ptmux;\033\033]"
    else
        printf "\033]"
    fi
}

# More of the tmux workaround described above.
function _print_st() {
    if [[ $TERM == screen* ]]; then
        printf "\a\033\\"
    else
        printf "\a"
    fi
}

function _load_version() {
    if [ -z ${IMGCAT_BASE64_VERSION+x} ]; then
        IMGCAT_BASE64_VERSION=$(base64 --version 2>&1)
        export IMGCAT_BASE64_VERSION
    fi
}

function _b64_encode() {
    _load_version
    if [[ $IMGCAT_BASE64_VERSION =~ GNU ]]; then
        # Disable line wrap
        base64 -w0
    else
        base64
    fi
}

function _b64_decode() {
    _load_version
    if [[ $IMGCAT_BASE64_VERSION =~ fourmilab ]]; then
        BASE64ARG=-d
    elif [[ $IMGCAT_BASE64_VERSION =~ GNU ]]; then
        BASE64ARG=-di
    else
        BASE64ARG=-D
    fi
    base64 $BASE64ARG
}

# _print_image filename inline base64contents print_filename
#   filename: Filename to convey to client
#   inline: 0 or 1
#   base64contents: Base64-encoded contents
#   print_filename: If non-empty, print the filename
#                   before outputting the image
function _print_image() {
    _print_osc
    printf '1337;File='
    if [[ -n $1 ]]; then
        printf "name=%s;" "$(printf "%s" "$1" | _b64_encode)"
    fi

    printf "%s" "$3" | _b64_decode | wc -c | awk '{printf "size=%d",$1}'
    printf ";inline=%s" "$2"
    printf ":"
    printf "%s" "$3"
    _print_st
    printf '\n'
    if [[ -n $4 ]]; then
        echo "$1"
    fi
}

function _error() {
    echo "_ERROR: $*" 1>&2
}

function _show_help() {
    echo "Usage: imgcat [-p] filename ..." 1>&2
    echo "   or: cat filename | imgcat" 1>&2
}

function _check_dependency() {
    if ! (builtin command -V "$1" >/dev/null 2>&1); then
        echo "imgcat: missing dependency: can't find $1" 1>&2
        exit 1
    fi
}

function imgcat() {
    if [ -t 0 ]; then
        has_stdin=f
    else
        has_stdin=t
    fi

    # Show help if no arguments and no stdin.
    if [ $has_stdin = f ] && [ $# -eq 0 ]; then
        _show_help
        exit
    fi

    _check_dependency awk
    _check_dependency base64
    _check_dependency wc

    # Look for command line flags.
    while [ $# -gt 0 ]; do
        case "$1" in
        -h | --h | --help)
            _show_help
            exit
            ;;
        -p | --p | --print)
            print_filename=1
            ;;
        -u | --u | --url)
            _check_dependency curl
            encoded_image=$(curl -s "$2" | _b64_encode) || (
                _error "No such file or url $2"
                exit 2
            )
            has_stdin=f
            _print_image "$2" 1 "$encoded_image" "$print_filename"
            set -- "${@:1:1}" "-u" "${@:3}"
            if [ "$#" -eq 2 ]; then
                exit
            fi
            ;;
        -*)
            _error "Unknown option flag: $1"
            _show_help
            exit 1
            ;;
        *)
            if [ -r "$1" ]; then
                has_stdin=f
                _print_image "$1" 1 "$(_b64_encode <"$1")" "$print_filename"
            else
                _error "imgcat: $1: No such file or directory"
                exit 2
            fi
            ;;
        esac
        shift
    done

    # Read and print stdin
    if [ $has_stdin = t ]; then
        _print_image "" 1 "$(cat | _b64_encode)" ""
    fi
}