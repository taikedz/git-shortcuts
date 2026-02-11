gits:fp() {
    local remotes=($(git remote))
    local rem
    for rem in "${remotes[@]}"; do
        gits:run fetch "$rem"
        gits:run remote prune "$rem"
    done
}

