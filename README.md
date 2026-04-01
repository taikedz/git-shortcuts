# Git Shortcuts

A utility to help with long-winded git commands that are frequently useful (therefore frequently typed), and some common activities can be sped-up a little.

This tool can either be used to run commands using shorthands, or just to provide reminders, letting you type them yourself (learn by doing!)

You can re-alias your git command to gits: `alias git=gits`. This will still allow auto-complete to work. Any commands not implemented in `gits` will simply pass through to the native git command.

## Features

`gits` provides short-hand commands for common long-winded or hard-to-remember git commands.

Find out your current status

    $ gits
    /home/user/git/github/taikedz/git-shortcuts
    git status -sb -uall
    ## master...origin/master [ahead 1]

    (see also: gits fs)

Do a fetch/status check

    $ gits fs

See diffs, always in colour

    $ gits file1 file2 file3

Commit the same files - use up arrow and tack on `-m "MESSAGE"`

    $ gits file1 file2 file3 -m "My commit message"

... and get warnings if you commit on master ...

	$ gits . -m
    You are comitting on master - continue ? [y/N] > n
    Set 'allow_master_commits = false' in .git-shortcuts to make this decision permanent.
    ERROR FAIL: Abort

See the log in color, with decorations (if your system's default config doesn't do this automatically), in oneline mode

    $ gits log
    git log --color --decorate=short --oneline 
    8d7c337 (HEAD -> master) Make use of 'less' configurable, rework help
    4dd3e2b (origin/master) Pull message is OK when repo is OK
    86607ba Add status check for specified directories
    16c9052 fix pull verification issue
    1a94b82 Add pull check, change log command options


See the log graph, in colour, with decorations, in oneline mode

    $ gits log -g [-a]

    # versus `git log [--all] --graph --oneline --decorate=short --color`

Save and apply different profiles

    # One-time setup
    $ gits profile save pro "Professional Name" "coder@site.net"
    $ gits profile save user2 "ThatGit" "git@large.net"

    $ gits profile apply pro

    $ gits profile
    Current config:
      Name:  Professional Name
      Email: coder@site.net

Controlled rebase - determine what section of your current branch to move to a new base, rather than rely on auto-detection of the shared root

    $ gits rebase oldbase newbase

Folder branch checkout - use the current branch as a folder for a new branch, or reuse current folder branch for a new folder branch

    $ git checkout -b feature-1  # ---> "feature-1" branch created and switched to
    $ gits fbranch task1         # ---> "feature-1/task1" branch created and switched to
    $ gits fbranch task2         # ---> "feature-1/task2" branch created and switched to

Ticket detection - detect a ticket number and apply it on commit message

    $ gits ticket-pattern '^[A-Z]+-[0-9]+'
                                 # default pattern is '^(?:[A-Z]+-)?[0-9]'
    $ gits checkout -b TKT-123-demonstrate-ticket
    $ gits . -m Some work        # ----> Creates a commit with message "TKT-123 Some work"

( and more to come ... )

