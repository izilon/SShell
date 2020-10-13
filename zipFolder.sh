#!/bin/bash
<<COMMENT
##################################################################
####                                                          ####
####              SHELL SCRIPT TEMPLATE                       ####
####                                                          ####
##################################################################

SCRIPT NAME      : zipFolder.sh

AUTHOR           : Rodolfo Siqueira

DESCRIPTION      : Shell script to gzip all files inside a folder bigger than 1Gb 

VERSION          : 1.0 - Initial Version
				   1.1 - Gzip files has at least 500MB

SUGGESTION	 : v.1.2 (to be implemented)
		   Add a file from where this script is going to get the folder 
		   list so that Support Team just have to edit the folders and not the code 
		   itself.

#################################################################
#################################################################
COMMENT

#First parameter is the path
URL="/diskmw/NAS/example-name"
#URL="/diskmw/NAS/example-name"
#Second parameter is extension
EXT="csv"

echo "=========================================================== "
echo "The folder to be compressed is: $URL"
echo "The extension that will be considered is: $EXT"
echo "=========================================================== "
#The line below is from v.1.0 - Searches 1GB files
#folderlist="$(du -Sh $URL | egrep '^*.[0-9]G|^*..[0-9]G' | uniq | sort -h -k 1)"


#The line below is from v.1.1 - Searches 500MB files
folderlist="$(du -Sh $URL | egrep '^*.[0-9]G|^*..[0-9]G|^*[5-9][0-9][0-9]M' | uniq | sort -h -k 1)"
echo "The folder(s) that are above 500MB are:"
echo "$folderlist">folder.log
echo "=========================================================== "
list1="$(cut -d$'\t' -f2- folder.log)"
echo "$list1"
echo "=========================================================== "
echo "Last chance to stop before compressing"
echo "=========================================================== "
echo "Initializing"
<<COMMENT
##################################################################
#            	     Progress Bar (Start)     		         	 #	
##################################################################
COMMENT
for i in {1..7}
do 
	echo -ne '#########'
	sleep 1
done 

echo -ne '\n'
sleep 1
<<COMMENT
##################################################################
#            	     Progress Bar (End)	     		         #	
##################################################################
COMMENT

list="$(find $list1 -type f -name '*.'$EXT'' -mtime +7)"
echo "$list"
if [ ! -z "$list" ]; then
#Commnet below line to print or not the files to removed
#       echo "Files in folder to be compressed: "
        echo "=========================================== "
        echo "$list">files.log
#Comment below line to test before removing
	gzip -r -v $list
fi
folderlist=""
list1=""
list=""

