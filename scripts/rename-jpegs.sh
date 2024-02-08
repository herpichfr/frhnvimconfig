#!/bin/bash
#
# script to rename jpeg files using input name by the user
# Herpich F. R.

function PrintHelp {
    echo usage: get_raw_imgs.sh [-l] [list of nights]

    echo "--newname       New general name for the images"
    exit 0

}

if [ "$1" == "" ]; then
    PrintHelp
    exit 0
fi

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

# check if find is installed
if [[ ! -x /usr/bin/find ]]; then
    echo "The command find is not installed. Exiting..."
    exit 1
fi

counter=1

IFS=$'\n'
for imagename in $(/usr/bin/find ./ -iname "*.jpeg"); do
    imagenamenospace=$(echo $imagename | tr " " "\ ")
    extension=$(echo $imagename | awk -F . '{print $NF}')

    newimagename=$(echo $(echo $newname | tr " " "\ ")_$(printf "%04d" $counter).${extension})
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
