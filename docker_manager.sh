#! /bin/bash

# Last Change: 890218
clear
# WELCOME SCRREN

RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
WHITE=$(echo -en '\033[01;37m')

#-------------------------------------------------------------------------------
# Helper functions
#-------------------------------------------------------------------------------

function error_message()
{
	echo -e "[ERROR]: ${RED}$1${RESTORE}"
}

function info_message()
{
	echo -e "${WHITE}$1${RESTORE}"
}

function warning_message()
{
	echo -e "[WARN]: ${YELLOW}$1${RESTORE}"
}

function success_message()
{
	echo -e "${GREEN}$1${RESTORE}"
}

function human_readable_filesize(){
	size=$(($1*100))
	for unit in KB MB GB TB PB EB ZB YB
	do
		if [ $size -lt 102400 ]
		then
			echo -e $(($size/100)).$(($size%100))"${unit}"
			return
		fi
		size=$((size/1024))
	done
}


#-------------------------------------------------------------------------------
# Conditional part
#-------------------------------------------------------------------------------

# This part checks if requested action satisfy prequisits.
action=$1
subaction=$2

if [[ $EUID -ne 0 ]]; then
	warning_message "Super User privilages needed" 2>&1
	exit 1 
fi



function print_all()
{
	success_message "########################### all container #####################"
	docker ps -a

	success_message "########################### all images ########################"
	docker images

	success_message "########################### all network #######################"
	docker network ls

	success_message "########################### all volumes ########################"
	docker volume ls

}

function print_all_dangling_images()
{	
	clear
		if [ $? -ne 0 ]; then
		error_message "Failed."
		exit 10
	fi

	if [ "$1" == "-d" ]; then
		docker rmi $(docker images -f dangling=true) 2> /dev/null
		if [ $? == '0' ]; then
			success_message "deleted all dangeling images"
		else
			error_message "deleting all dangeling images failed"
		fi
	else
		success_message "########################### dangling images #####################"
		docker images -f dangling=true
	fi
}

case $action in
"print")
	case $subaction in
	"all")
		print_all
	;;
	esac
;;

"images")
	case $subaction in
	"dangling")
		print_all_dangling_images "$3"
	;;
	esac
;;

esac

exit 0