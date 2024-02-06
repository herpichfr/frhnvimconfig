#!/bin/bash
#
# script to rename jpeg files using input name by the user
# Herpich F. R.

function PrintHelp {
    echo usage: get_raw_imgs.sh [-l] [list of nights]

    echo "--newname       New general name for the images"
    exit 0

}

while [ "$1" != "" ]; do
    case $1 in
        --newname   )           shift
                                newname=$1
                                ;;
        *  )                    PrintHelp
                                exit
    esac
    shift
done

counter=1

IFS=$'\n'
for imagename in $(/usr/bin/find ./ -iname "*.jpeg"); do
    imagenamenospace=$(echo $imagename | tr " " "\ ")

    newimagename=$(echo "${newname}-$(printf '%03d' ${counter}).jpeg")
    if [[ -f ${newimagename} ]]; then
        echo Image ${newimagename} already exists! Not renaming...
    else
        echo "Renaming image" ${imagename} to ${newimagename}...
        cp ${imagename} ${newimagename}
        if [[ -f ${newimagename} ]]; then
            rm ${imagenamenospace}
        fi
    fi
    ((counter++))
done
IFS=''
