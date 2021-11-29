#!/bin/bash

#get and set param from input
try_interval=$2
try_number=$4
try_command=$5

#loop for input try number
for (( i=0 ; i<$try_number; i++)); do
   #execute input command
   eval $try_command > /dev/null 2>&1
   #check command is OK?
    if [ $? -eq 0 ]
    then
      exit 0
    fi
    #thread sleep for input interval by second
    sleep $try_interval
done
#input command not ok and send error to stderr
echo 'your command not success in '$try_number 'try!' >&2
exit 1
