### log [file | graph [short]] [FILE ...] Usage:help-log
#
# Show logs for files, or graph
#
###/doc

gits:log() {
    gits:local-help log "$@"
    local options=(--color --decorate=short)

    if [[ "${1:-}" = files ]]; then
        options+=(--name-only)
        shift
    elif [[ "${1:-}" = graph ]]; then
        options+=(--graph --all)
        shift

        if [[ "${1:-}" = short ]]; then
            options+=(--oneline)
            shift
        fi
    fi

    git log "${options[@]}" "$@"
}
