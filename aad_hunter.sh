#/bin/bash

usage="$(basename "$0") [-h] [-d directory] [-a assembly_command] [-b hex_value] -- program to find assembly command to hex value from all files in a specified directory

where:
    -h  show this help text
    -d  directory that has files to search ex: /var/opt/
    -a  assembly to search for ex: \"call esp\"
    -b  hex to search for ex: \"ff d4\""

while getopts ha:b:d: option
do
case "${option}"
in
h) echo "$usage"
   exit
   ;;
d) DIRECTORY=${OPTARG};;
a) ASSEMBLY=${OPTARG};;
b) HEX=${OPTARG};;
esac
done

if [ ! -z "$DIRECTORY" ]
then
	DIRECTORY+="*"
else
	echo "No directory specified"
	echo "Run again... noob!"
	exit 0
fi

if [ ! -z "$ASSEMBLY" ] && [ ! -z "$HEX" ]
then
	echo "-a and -b are not to be used together"
	echo "Try harder... n00b!"
	exit 0
fi

if [ ! -z "$ASSEMBLY" ]
then
	#echo $ASSEMBLY
	cat <<- EOF > tmp.c
	#include <stdio.h>
	
	int main() {
		asm( "$ASSEMBLY" );  //take the commandline argument here
		return 0 ;
	}
	EOF
	gcc tmp.c -masm=intel -o tmp.exe
	MOD_ASSEMBLY="$(echo $ASSEMBLY | sed -e 's/[[]/\\[/g' | sed -e 's/[]]/\\]/g' | sed -e 's/ /[ ]*.*/g')"
	#MOD_ASSEMBLY="$(echo $MOD_ASSEMBLY | sed -e 's/[]]/\\]/g')"
	#MOD_ASSEMBLY="$(echo $MOD_ASSEMBLY | sed -e 's/ /[ ]*.*/g')"
	#echo $MOD_ASSEMBLY
	#exit 0

	HEX_OUTPUT="$(objdump -S tmp.exe -M intel | grep -i -e "$MOD_ASSEMBLY" | cut -d$'\t' -f2 | sed 's/  //g')"
	if [ ! -z "$HEX_OUTPUT" ]
	then	
		echo "Searching for the following hex code: " $HEX_OUTPUT
	else
		echo "No matching hex code found"
		echo "Run again ya n000bal00b"
		exit 0
	fi

	for filename in $DIRECTORY
	do
		ofile="${filename}.s"
		echo "$(basename "$filename")"
		objdump -S $filename -M intel > $ofile 2>/dev/null
		grep -i "$HEX_OUTPUT" $ofile
		rm -f $ofile
	done
fi

if [ ! -z "$HEX" ]
then
	#echo $HEX
	[[ "$HEX" = "${HEX%[[:space:]]*}" ]] && MOD_HEX="$(echo $HEX | sed 's/.\{2\}/& /g')" || MOD_HEX=$HEX
	echo "Searching for the following hex code: " $HEX
	for filename in $DIRECTORY
	do
		ofile="${filename}.s"
		echo "$(basename "$filename")"
		objdump -S $filename -M intel > $ofile 2>/dev/null
		grep -i "$MOD_HEX" $ofile
		rm -f $ofile
	done	
fi

rm -f tmp.c tmp.exe
