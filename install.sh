#!/bin/bash

bins="$HOME/.local/bin/"
if [[ "$UID" = 0 ]]; then
	bins=/usr/local/bin
fi

[[ -d "$bins" ]] || mkdir -p "$bins"

cp bin/gits "$bins"

echo "'gits' is now installed"
