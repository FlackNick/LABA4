#!/bin/bash

function create(){
	if [[ $1 == false ]]
	then 
		mkdir $2
		echo "$3 - Was made new backup named $2" >> $log_path; 
	fi
}

function if_backup_there(){
	if [ -e $1 ] 
	then 
		echo "$2 - Upgrade from $1 to $1::$2" >> $3
	else 
		echo "$2 - $1 was made" >> $3
	fi
}

function DO(){
	is_created=false
	log_path=/home/user/backup-report
	now="$(date +%F)"
	dir_name=/home/user/Backup-$now
	for i in 0 1 2 3 4 5 6 7
	do
		backup=/home/user/Backup-$(date +%F --date="$i days ago")
		echo "Searching $backup"
		if [ -e "$backup" ] 
		then 
			dir_name=$backup
		 	is_created=true
		  	echo "$backup exists!"
		   	break 
		fi
	done
	create "$is_created" "$dir_name" "$now"
	for file in "$(ls /home/user/source)"
	do
		will_backuped=/home/user/source/$file
		backup=$dir_name/$file
		if ! [ -e $backup ] || ! [[ "$(wc -c $will_backuped)" = "$(wc -c $backup)" ]]; 
		then
			if_backup_there "$backUp" "$now" "$log_path"
			cp $will_backuped $dir_name --backup --suffix=.$now
		fi
	done
}

DO 

