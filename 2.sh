#!/bin/bash
IFS=$'\n'

function UX/UI(){
	echo "This file?" 
	echo "-_-_- $1 -_-_-"
	echo "[y/n]"
}

function action1(){
	if [ -e $2 ]
	then
		echo "You must change name of file!"
		echo "Write something:"
		read answer
		ln $1 "$2$answer" 
		rm $1
		cat "$FILE" | grep -v "$STR"
		echo "File $2 untrashed"
		exit 0 
	fi
	ln $1 $2
	rm $1 
	echo "File $2 untrashed"
}

function action2(){
	ln $1 ~/$2 
	rm $1
	echo "Directory didn't found, untrashed to user's home" 
}

function DO(){
	for file in $(grep $1 ~/.trash.log | awk "{print \$0}"); 
	do
		clone=~/.trash/"$(echo $file | awk '{print $2}')"
		path="$(echo $file | awk '{print $1}')"
		UX/UI "$path"
		read answer
		if [[ $answer = "y" ]] 
		then
			if [ -e "$(dirname $path)" ]
			then 
				action1 "$clone" "$path"
			else 
				action2 "$clone" "$1"
			fi
		exit 0
	fi
	done
}

DO $1