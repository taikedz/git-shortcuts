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
