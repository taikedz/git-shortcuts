# Git Shortcuts

A utility to help with long-winded git commands.

A clean-slate implementation after re-thinking what [`git-newbie`](https://github.com/taikedz/git-newbie) was trying to do.

Git has quite a few long-winded commands that are frequently useful, and some common activities can be sped-up a little.

## Features

Find out your current status

    $ gits
	Fetching origin
	On branch master
	Your branch is up to date with 'origin/master'.


See individual diffs in colour in a `less` session each

    $ gits file1 file2 file3

Commit the same files

    $ gits file1 file2 file3 -m my commit message

... and get warnings if you commit on master ...

	$ gits . -m
		You are comitting on master - continue ? [y/N] > n
		Set 'allow_master_commits = false' in .git-shortcuts to make this decision permanent.
		ERROR FAIL: Abort

See the log in color, with decorations (if your system's default config doesn't do this automatically)

    $ gits log

        commit 92bcf27cbe6ce2b395d39584e03f9ddf0fee5b0f (HEAD -> master, origin/master)
        Author: Coder <email@site.net>
        Date:   Fri Jul 20 15:04:04 2018 +0100

            Implement preferences and store (for master guard and profiles)
                
            * Safe mode enabled set -euo pipefail
            * ...

Save and apply different profiles

    $ gits profile put coder "Coder Name" "coder@site.net"
    $ gits profile apply coder

    # ---> sets git config user.name and user.email

( and more to come ... )
