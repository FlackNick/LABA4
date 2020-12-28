for file in $(grep $1 ~/.trash.log | awk "{print \$0}"); 
	do
    echo $file
	done