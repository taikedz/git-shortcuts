gits:common:fetch-status() {
    git fetch --all
    git status
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
    git branch | grep '^*' | cut -f 2 -d' '
}

gits:remote-exists() {
    local remote_name target
    target="$1"; shift

    while read remote_name; do
        if [[ "$remote_name" = "$target" ]]; then
            return 0
        fi
    done < <(git remote)

    return 1
}
