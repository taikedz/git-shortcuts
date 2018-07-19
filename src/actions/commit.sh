### Commit -m[m] [MESSAGE] Usage:help-commit
#
# After a series of items, if -m or -mm are found, performs an add + commit
#
# -m adds a new commit
# -mm amends the last commit
#
# if no MESSAGE is suppplied, an editor session is started
#
###/doc

gits:commit() {
    # need to add help that does not catch --help as part of message
    local files item arguments
    files=()
    arguments=()
    item="$1"

    while [[ ! "$item" =~ ^-mm?$ ]]; do
        files+=("$item")
        shift
        item="$1"
    done
    shift

    if [[ "$item" = -mm ]]; then
        arguments+=(--amend)
    fi

    if [[ -n "$*" ]]; then
        arguments+=(-m "$*")
    fi

    git add "${files[@]}"
    git commit "${arguments[@]}"
}
