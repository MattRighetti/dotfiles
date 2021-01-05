# Parse aliases folder
for alias_file ($ZSH_CUSTOM/aliases/*.zsh(N)); do
    source $alias_file
done
unset alias_file