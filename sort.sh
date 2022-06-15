#!/bin/sh
playlist="$1"
strip_begin="$2"
strip_end="$3"
ext="${4:-.m4a}"

[ -z "$playlist" ] && {
	echo Missing playlist\!\!\!
	exit 1
}

echo -n "Directory in which files are about to be modified:
$PWD
Are you sure? (Y/n) "
read ANSWER && {
	[ "$(tr '[:upper:]' '[:lower:]' <<< "$ANSWER")" = y ] && {

now=$(date +'%Y%m%d%H%M.%S')
now=${now%?????}00.01
cur=0

sorted=$(youtube-dl --flat-playlist -J "$playlist" | jq -r '.entries[].title'); 
IFS=$'\n'; for title in $sorted; do
	title="${title##$strip_begin}"
	title="${title%%$strip_end}"
	title="${title//\//|}"
	file="$title$ext"
	if [ -e ./"$file" ]; then
		cur=$((cur+1))
		echo Found $title, processing...
		touch -t $(bc <<< "$now+$cur") "$file"
		number=$(printf '%02d' $cur)
		mv "$file" "$number. $file"
	else
		echo $title not found, skipping...
	fi
done

	} || {
		echo nvm 
		exit 1
	}
}
