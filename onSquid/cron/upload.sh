#!/bin/bash

errLog="/root/cron/ERR-upload.log"
echo " --- STARTING upload.sh - Date is:" >> $errLog
date >> $errLog

lineCountVariableFile="/root/cron/lineCountVariableFile.txt"
lineCountVariable=$(cat $lineCountVariableFile)

uploadFile="/var/log/squid3/mysql/upload-mysql.log"
mysqlLogFile="/var/log/squid3/mysql/mysql.log"
pythonUploadScript="/root/cron/ninja-upload.py"

newLineCountVariable=$(wc -l $uploadFile | cut -d' ' -f1)
currentLineCount=$(wc -l $mysqlLogFile | cut -d' ' -f1)
lineCountDelta=$(expr $currentLineCount - $lineCountVariable)


if [[ $lineCountVariable -lt 0 ]] && [[ $currentLineCount -gt 0 ]]
then
	echo "lineCountVariable equals 0"
	cp $mysqlLogFile $uploadFile
	newLineCountVariable=$(wc -l $uploadFile | cut -d' ' -f1)
	echo $newLineCountVariable
	echo $newLineCountVariable > $lineCountVariableFile
	echo "start upload process"
	#upload 
	[ -f $uploadFile ] && cat /root/cron/top.txt >> $pythonUploadScript
	[ -f $uploadFile ] && rm $pythonUploadScript

	[ -f $uploadFile ] && cat /root/cron/top.txt >> $pythonUploadScript
	[ -f $uploadFile ] && cat $uploadFile >> $pythonUploadScript
	[ -f $uploadFile ] && cat /root/cron/bottom.txt >> $pythonUploadScript

	# handle case where port number is absent - db expects an int.
	[ -f $uploadFile ] && sed -i 's/(-,/(0,/g' $pythonUploadScript
	[ -f $uploadFile ] && chmod +x $pythonUploadScript >> $errLog 2>&1
	[ -f $uploadFile ] && python $pythonUploadScript >> $errLog 2>&1

	echo "finished uploading process"

elif [[ $lineCountVariable -gt 0 ]] && [[ $lineCountDelta -gt 0 ]]
then
	echo "lineCountDelta is greater than 0"
	echo "lineCountDelta: " $lineCountDelta
	rm $uploadFile
	tail -n +$lineCountVariable $mysqlLogFile > $uploadFile
	uploadFileLineCountVariable=$(wc -l $uploadFile | cut -d' ' -f1)
	newLineCountVariable=$(expr $uploadFileLineCountVariable + $lineCountVariable)
	echo $newLineCountVariable > $lineCountVariableFile

		#upload 
	[ -f $uploadFile ] && cat /root/cron/top.txt >> $pythonUploadScript
	[ -f $uploadFile ] && rm $pythonUploadScript

	[ -f $uploadFile ] && cat /root/cron/top.txt >> $pythonUploadScript
	[ -f $uploadFile ] && cat $uploadFile >> $pythonUploadScript
	[ -f $uploadFile ] && cat /root/cron/bottom.txt >> $pythonUploadScript

	# handle case where port number is absent - db expects an int.
	[ -f $uploadFile ] && sed -i 's/(-,/(0,/g' $pythonUploadScript
	[ -f $uploadFile ] && chmod +x $pythonUploadScript >> $errLog 2>&1
	[ -f $uploadFile ] && python $pythonUploadScript >> $errLog 2>&1

	echo "finished uploading process"

else
	echo " --- NO UPLOAD Executed ---" >> $errLog
	echo " meaning, hopefully the server has had no traffic since last attempt" >> $errLog

fi

echo " --- FINISHED upload.sh - Date is:" >> $errLog
date >> $errLog
