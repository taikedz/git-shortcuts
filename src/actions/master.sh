$%function gits:master(?target) {
    if [[ -z "$target" ]]; then
        gits:prefs:get "mastername"
    else
        gits:prefs:put "mastername" "$target"
    fi
}
