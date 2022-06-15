#!/bin/zsh
dir=( ${1:-*(/)} )
for album in $dir; do cd "$album" && for title in *; do
	exiftool -Album="${album##*- }" "$title"
	exiftool -Artist="${album%% -*}" "$title"
	exiftool -Title="${${title:4}%%.m4a}" "$title"
done && cd ..; done
