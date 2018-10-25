#%include git.sh version.sh args.sh

### version (ls|bump KEYWORD) Usage:help-version
#
# Get the last tagged version from git history, or suggest the next version
#
# Expects numerical version tags, separated with periods. May have a leading "v"
# e.g. `1.3.2`
#
# `ls`
#   Simply print the last version found in the tags of the branch's history
#
# `bump KEYWORD`
#   Use a keyword to suggest what the next version should be. The keywords available are
#
#   "patch", "fix", "bugfix" --> bump of patch-level version (3rd digit)
#
#   "fetaure", "minor"  --> bump of the minor version number (2nd digit)
#
#   "breaking", "major" --> bump of the major version number (1st digit)
#
###/doc

gits:version:get() {
    local version
    version="$(git:last_tagged_version)" || out:fail "No versions in history"

    out:info "Last version was ${version:1}"
}

$%function gits:version:suggest(keyword) {
    local version
    version="$(git:last_tagged_version)" || {
        out:info "No versions found. Suggestion: 0.1"
        exit 0
    }

    version="${version:1}" # blat the indicator

    if [[ "$version" =~ ^v ]]; then
        version="${version:1}"
    fi

    case "$keyword" in
        patch|bugfix|fix)
            keyword=patch
            ;;
        feature|minor)
            keyword=minor
            ;;
        breaking|major)
            keyword=major
            ;;
        *)
            out:fail "Not a valid keyword '$keyword'"
            ;;
    esac

    out:info "Suggest: $(version:next "$keyword" "$version")"
    if [[ "$(gits:current-branch)" != master ]]; then
        out:warn "Not on master"
    fi
}

$%function gits:version:_dispatch(?action) {
    gits:local-help version "$action" "$@"

    [[ -n "$action" ]] || {
        gits:version:get
        exit
    }

    case "$action" in
    ls)
        gits:version:get
        ;;
    bump)
        gits:version:suggest "$@"
        ;;
    *)
        out:fail "Invalid action '$action'. Try --help"
        ;;
    esac
}
