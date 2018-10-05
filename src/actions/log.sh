### log [OPTIONS] [FILES ...] Usage:help-log
#
# Show short log, in colour.
#
# The following option shortcuts are specific to gits:
#
# files|-f
#   Show files. Equivalent to standard option --name-only
#
# graph|-g
#   Show as graph, on a single line unless "long" is specified
#
# long|-l
#   Show long format instead of oneline format
#
# The [FILES ...] are optional, and can also be any other git-log standard options
#
###/doc

gits:log() {
    local arg
    gits:local-help log "$@"

    local options=(--color --decorate=short)
    local add_short=true

    if [[ "${1:-}" = graph ]] || [[ "${1:-}" = -g ]]; then
        options+=(--graph --all)
        shift

    fi

    for arg in "$@"; do
    case "$arg" in
    files|-f)
        options+=(--name-only)
        shift
        ;;
    graph|-g)
        options+=(--graph --all)
        shift
        ;;
    long|-l)
        add_short=false
        shift
        ;;
    *)
        break
        ;;
    esac
    done

    if [[ "$add_short" = true ]]; then
        options+=(--oneline)
    fi

    gits:pager gits:run log "${options[@]}" "$@"
}
