gits:store:create-get-file() {
    local filepath
    filepath="$(gits:store:get-file "$1")"
    touch "$filepath" || out:fail "Could not create '$storefile'"
    echo "$filepath"
}

gits:store:get-file() {
    local storefile fsubdir fname
    fsubdir="$(dirname "$1")" || out:fail "No file specified"
    [[ "$fsubdir" != . ]] || fsubdir=""

    fname="$(basename "$1")"
    storefile="$(gits:store:get-dir "$fsubdir")/$fname"

    echo "$storefile"
}

gits:store:get-dir() {
    local storedir
    storedir="$HOME/.config/git-shortcuts/${1:-}"
    mkdir -p "$storedir"
    echo "$storedir"
}
