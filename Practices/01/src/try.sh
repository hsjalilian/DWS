#!/bin/bash

#default values
deafult_interval=5
default_number=3

#internal param
try_interval=''
try_number=''
try_command=''

#loop to end of input
while true; do
  case $1 in
    -i)
     try_interval=$2
     shift 2
     ;;
    -n)
     try_number=$2
     shift 2
     ;;
    *)
     try_command=$1
     break
     ;;
  esac
done


if [[ -z "$try_interval" ]];
then
  try_interval="${TRY_INTERVAL:-$deafult_interval}" #set default with check
fi

if [[ -z "$try_number" ]];
then
  try_number="${TRY_NUMBER:-$default_number}" #set default with check
fi
#set ddeafult with check
try_command="${try_command:-$TRY_COMMAND}"

#check for command not empty
if [[ -z "$try_command" ]];
then
     1>&2 echo 'command is required!'
     exit 1
fi

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
