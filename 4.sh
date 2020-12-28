#!/bin/bash
function DO{
	backup="$(ls -d /home/user/*/ | grep Backup | sort -r | head -n 1)"
	if ! [ -e $backup ]
	then 
		echo "Backups in /home/user don't exist"
		exit 0
	fi
	for file in "$backup"*
	do
		if [[ $file =~ .*\.[0-9]{4}-[0-9]{2}-[0-9]{2} ]]
		then 
			continue
		fi
		cp --update $file /home/user/restore
		echo Copying $file
	done
	echo "Complete!"
}

DO
