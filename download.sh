#!/bin/sh
youtube-dl -Rinfinite -i -f 'm4a/bestaudio' -o '%(playlist_title)s/%(title)s.%(ext)s' \
	--embed-thumbnail $@
