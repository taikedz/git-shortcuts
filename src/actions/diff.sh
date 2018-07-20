### diff FILE ... Usage:help-diff
# Display diff of each file
###/doc

gits:check-commit() {
    local x
    for x in "$@"; do
        if [[ "$x" =~ ^-mm?$ ]]; then
            return 1
        fi
    done

    return 0
}

gits:diff() {
    gits:check-commit "$@" || {
        gits:commit "$@"
        return
    }

    echo "Diffs for: $action $*"

    gits:local-help-noempty diff "$@"

    local item

    for item in "$@"; do
        git diff --color HEAD -- "$item" | less -R
    done
}
