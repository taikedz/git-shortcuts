gits:branch:show-upstream() {
    git status -sb|grep -oP '^## \K.+'|sed 's/\.\.\./ --> /'
}

gits:branch:show-all() {
    git branch -vv
}

gits:branch:_dispatch() {
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
