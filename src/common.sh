gits:local-help() {
    local section="$1"; shift

    if [[ "$*" =~ --help ]]; then
        autohelp:print "help-$section"
        exit 0
    fi
}

gits:local-help-noempty() {
    if [[ -z "$*" ]]; then
        autohelp:print "help-$section"
        exit 0
    fi

    gits:local-help "$@"
}

gits:current-branch() {
    git branch | grep '^*' | cut -f 2 -d' '
}

gits:remote-exists() {
    local remote_name target
    target="$1"; shift

    while read remote_name; do
        if [[ "$remote_name" = "$target" ]]; then
            return 0
        fi
    done < <(gits:run remote)

    return 1
}

gits:run() {
    local token

    echo -en "\033[30;1;43mgit " >&2
    for token in "$@"; do
        if [[ "$token" =~ " " ]]; then
            echo -n "\"$token\" " >&2
        else
            echo -n "$token " >&2
        fi
    done
    echo "$CDEF" >&2

    if gits:use_less; then
        sleep "$GITS_use_less_ms"
    fi

    if [[ "${GITS_no_execute:-}" != true ]]; then
        if gits:use_less; then
            git "$@" | less -R
        else
            git "$@"
        fi
    fi
}

gits:use_less() {
    #GITS_use_less_ms denotes the time to sleep before invoking the pager
    [[ "${GITS_use_less_ms:-}" =~ ^[0-9.]+$ ]] && [[ "${GITS_pager_wrapping_on:-}" = true ]]
}

gits:pager() {
    GITS_pager_wrapping_on=true
    "$@"
    unset GITS_pager_wrapping_on
}
