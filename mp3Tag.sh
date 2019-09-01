#! /bin/bash
h_FLAG=' ';
b_FLAG=' ';

while getopts hbc:s: option
do
	case "${option}"
		in
		h) h_FLAG='true' ;;
		b) b_FLAG='true' ;; 
		c) CUTOFF=${OPTARG};;
		s) s_FLAG=${OPTARG} ;;
	esac
done

if [ "${h_FLAG}" == "true" ]
then
	echo -e "
	Help Page:
	
	mp3 Tag is an addon bash script that utilizes mid3v2. You can
	install mid3v2 by \033[33msudo apt-get install python-mutagen\e[0m.

	Avaialble Commands:
	-h: Help!
	-b: Cut Backwards
	-c: Cutoff Text [Requires Arguments]
	-s: Single File [Requires Arguments]
	"

	exit
fi

if [[ ! -z "${s_FLAG}" && -f "${s_FLAG}" ]]
then
	
	if [ "${s_FLAG##*.}" != "mp3" ]
	then
		echo -e "I CAN ONLY TAG \033[36m.mp3s\e[0m"
		exit
	fi

	bfilename=$(basename -- "$s_FLAG")
	filename="${bfilename%.*}"

	if [ "${b_FLAG}" == "true" ]
	then
        	filename="${filename%$CUTOFF*}"
        else
        	filename="${filename##*$CUTOFF}"
	fi
	
	mid3v2 -t "${filename}" "$s_FLAG"
        echo -e "\033[33m${bfilename}\e[0m has been \033[34mTitle\e[0m Tagged with \033[32m${filename}\e[0m."

	exit
else
	echo -e "\033[31mUNABLE\e[0m TO LOCATE \033[33m${s_FLAG}"
	exit
fi

for entry in "$PWD"/*
do
	bfilename=$(basename -- "$entry")
	extension="${bfilename##*.}"
	#echo $extension
	
	if [ $extension == "mp3" ]
	then
		filename="${bfilename%.*}"
		if [ ! -z "$CUTOFF" ]
		then
			if [ "${b_FLAG}" == "true" ]
			then
				filename="${filename%$CUTOFF*}"
			else
				filename="${filename##*$CUTOFF}"
			fi
		fi
		mid3v2 -t "${filename}" "$entry"
		echo -e "\033[33m${bfilename}\e[0m has been \033[34mTitle\e[0m Tagged with \033[32m${filename}\e[0m."

	fi
done
