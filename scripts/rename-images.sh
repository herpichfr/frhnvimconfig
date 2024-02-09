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
    ;; esac
    shift
done

# check if find is installed
if [[ ! -x /usr/bin/find ]]; then
    echo "The command find is not installed. Exiting..."
    exit 1
fi

counter=1

shopt -s globstar
find ./ -regex '.*\.\(jpg\|JPG\|jpeg\|JPEG\|png\|PNG\|gif\|GIF\|bmp\|BMP\|tiff\|TIFF\|tif\|TIF\|ppm\|PPM\|pgm\|PGM\|pbm\|PBM\|pnm\|PNM\|webp\|WEBP\|heic\|HEIC\|heif\|HEIF\|bpg\|BPG\|jp2\|JP2\|j2k\|J2K\|jpf\|JPF\|jpx\|JPX\|jpm\|JPM\|mj2\|MJ2\)' | while read fname; do
    extension=$(echo "$fname" | awk -F . '{print $NF}')
    newimagename=$(echo "$newname"_"$(printf "%04d" "$counter").$extension")
    echo "Renaming image" "$fname" to "$newimagename"...
    cp "$fname" "$newimagename"
    if [ -f "$newimagename" ]; then
        echo "Image" "$fname" renamed to "$newimagename" successfully.
        rm "$fname"
    else
        echo "Image" "$fname" could not be renamed to "$newimagename".
    fi
    ((counter++))
done
