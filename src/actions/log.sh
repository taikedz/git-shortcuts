### log [graph [long]] [OPTIONS] [FILES ...] Usage:help-log
#
# Show logs , optionally in graph format with single lines, or long if specified.
#
# Options can be any git-log options, or one of the following:
#
# --files
#
#   Show files. Equivalent to standard option --name-only
#
###/doc

gits:log() {
    local arg
    gits:local-help log "$@"

    local options=(--color --decorate=short)

    if [[ "${1:-}" = files ]]; then
        options+=(--name-only)
        shift
    elif [[ "${1:-}" = graph ]]; then
        options+=(--graph --all)
        shift

        if [[ "${1:-}" != long ]]; then
            options+=(--oneline)
        else
            shift
        fi
    fi

    for arg in "$@"; do
    case "$arg" in
    --files)
        options+=(--name-only)
        shift
        ;;
    *)
        break
        ;;
    esac
    done

    gits:run log "${options[@]}" "$@"
}
