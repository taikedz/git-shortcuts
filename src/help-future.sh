# Still to implement:

# See user profiles, configure user profile, configure local repo with profile
#
#   gits profile list
#   gits profile put PROFILE NAME EMAIL
#   gits profile apply PROFILE
#
# Modify remote - if the URL starts with '%' then it is a substitution
# the first character after `%` defines the pattern separator
#
# e.g. gits remote origin %/github.com/user@github.com/
# e.g. gits remote origin %|https://|ssh://git@|
#
#   gits remote REMOTE { URL | SUBSTITUTION }
#
# Create github repo
#
#   gits github create USER/PROJECT DESCRIPTION
#
# Delete github branch or tag
#
#   gits github delete { tag | branch } REFNAME
#
# Clean the repository
#
#   gits clean
#
# Create mailing patch, apply mailing patch
# specify file `-` to use stout/stdin
#
#   gits patch get FROM_REF TO_REF [FILE]
#   gits patch apply [FILE]
#
# List license names,
#  add a license file to license library,
#  dump license text,
#  apply license text to top of file after first line
#
# e.g. gits license add gplv3 gplv3-full-text.txt
# e.g. gits license add gplv3-c gplv3-short-with-c-comments.txt
#
# e.g. gits license cat gplv3 > ./LICENSE.txt
# e.g. gits license cat gplv3-c > src/new-file.c
# e.g. gits license apply glv3-sh src/existing-file.c
#
#   gits license
#   gits license add NAME LICENSEFILE
#   gits license cat NAME
#   gits license apply NAME SOURCEFILE
