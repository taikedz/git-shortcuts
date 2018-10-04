gits:branch:show-upstream() {
    gits:run status -sb|grep -oP '^## \K.+'|sed 's/\.\.\./ --> /'
}

gits:branch:show-all() {
    gits:run branch -vv
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
