gits:common:fetch-status() {
    gits:run fetch --all
    gits:run status
}

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
    gits:run branch | grep '^*' | cut -f 2 -d' '
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

    if [[ "${GITS_no_execute:-}" != true ]]; then
        git "$@"
    fi
}
