# License branch

This branch intends to implement a `license` subcommand for easily applying and changing license of a project.

By running for example

    gits license apply lgplv3

the script can recurse through the entire project, and add short license boilerplate to the top of all files (taking shebang and `#%include` lines into account)

It would also add a full-text of a license to the root of the project.

## Areas

* maintain a store of licenses (long and short)
* maintain a store of comment tokens -> file extensions

* command to add license file to the repository
* command to add license to top of files, inside a marked area like `// -- License --` , `// -- /License --`
* command to change license throughout project, except in sub-directories
