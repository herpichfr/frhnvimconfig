#!/bin/bash
# Fabio R Herpich -- herpich@usp.br
# get T80S' images for backup

function PrintHelp {
    echo usage: get_raw_imgs.sh [-l] [list of nights]

    echo "-p | --port       ports to test"
    echo "-l | --level      level of hacking"
    echo "-h | --help       print this help"
    exit 0

}

while [ "$1" != "" ]; do
    case $1 in
        -p | --port   )         shift
                                port=$1
                                ;;
        -l | --level  )         shift
                                lvl=$1
                                ;;
        *  )                    PrintHelp
                                exit
    esac
    shift
done

function hackstuff {
    # call first prints
    echo "Starting identification of target system"
    get_system=$(uname -ra)
    get_processes=$(ps auwx | grep root)
    get_processor=$(lscpu)

    echo $get_system
    sleep 0.1
    echo $get_processes
    echo $get_processor
}

function sendsignal {
    export C_GREEN='\e[01;32m'
    export C_RESET='\e[0m'
    printf "Getting target system properties."
    printf "${C_GREEN} Print some text..."
    printf "${C_GREEN} Print text that appears to be serious thing"
    printf "${C_GREEN} Give a break"
    printf "${C_GREEN} ?"
    printf "${C_GREEN} Get over with a lot of information. This simigly will impress some people"
    printf "${C_GREEN} Let us see if it works"
    printf "${C_GREEN} Make a small stop"
    sleep 0.2
    printf "${C_GREEN} AShould include a few symbols. Would be nice"
    printf "${C_GREEN} Need to get the NerdFOnts to improve this part"
    printf "${C_GREEN} I could save some random files here"
    printf "${C_GREEN} ............."
    printf "${C_GREEN} Downloading the data.... ${C_RESET}"
}

while true; do
    sendsignal
    sleep 0.5
    hackstuff
    sleep 1
done
