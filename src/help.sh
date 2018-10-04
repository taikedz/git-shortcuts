
### Git Shortcuts Usage:help
#
# Tool to provide shortcut commands to common onerous git operations.
#
# The tool displays the command, and executes them. To not execute the command, set `GITS_no_execute=true` in your environment
#
# Fetch and status
#
#   gits fs
#
# Individual diffs in less, independent of whether staged or not
#
#   gits FILES ...
#
# Add files, and commit - if no actual message is specified, an editing session is opened;
#  with the -m  option, use a regular commit;
#  with the -mm option, use an ammend commit
#
#   gits FILES ... -m[m] [MESSAGE ...]
#
# See log in color, with decorations;
#  optionally list files;
#  optionally use graph output, optionally with short messages;
#  any extra arguments for standard `git log`
#
#   gits log [files | graph [short]] [ARGS ...]
#
# Garbage collect commits and files that cannot be reached
#
#   gits gc
#
# Set the upstream remote for the current branch
#
#   gits push [REMOTE [BRANCH]]
#
###/doc

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
