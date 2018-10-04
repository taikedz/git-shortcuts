### gits branch [all] Usage:help-branch
#
# Show information about the current branch, or all branches
#
###/doc

gits:branch:show-upstream() {
    gits:run status -sb|grep -oP '^## \K.+'|sed 's/\.\.\./ --> /'
}

gits:branch:show-all() {
    gits:run branch -vv
}

gits:branch:_dispatch() {
    gits:local-help branch "$@"

    if [[ -z "$*" ]]; then
        gits:branch:show-upstream
        exit
    fi

    case "$1" in
    all)
        gits:branch:show-all
        ;;
    *)
        out:fail "Unknown 'branch' sub-operation '$1'"
        ;;
    esac
}
