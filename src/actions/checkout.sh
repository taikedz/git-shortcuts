### gits co [ ... ] Usage:help-checkout
# Checkout shorthands
#
# `gits co`
# 
# Checkout the master branch
# 
# `gits co TARGET [OPTIONS ...]`
#
# If TARGET is an existing local or remote branch, check it out
#
# Else if TARGET is an existing path, revert the file/path
#
# Else, offer to create and checkout a new branch
#
# OPTIONS are standard options for `git checkout` such that
#
# `gits co TARGET {OPTIONS ...}` --> `git checkout {OPTIONS ...} TARGET`
###/doc

$%function gits:checkout(?target) {

    if [[ -z "$target" ]]; then
        gits:run checkout master
        return
    fi

    gits:local-help checkout "$target" "$@"

    if gits:branch:_exists "$target"; then
        gits:run checkout "$@" "$target"

    elif [[ -e "$target" ]]; then
        gits:run checkout "$@" "$target"

    else
        askuser:confirm "'$target' does not exist - create it ?"
        gits:run checkout -b "$@" "$target"
    fi
}

