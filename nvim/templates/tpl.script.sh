#!/bin/sh
###############################################################################
#File: %FFILE%
#
#License: %LICENSE%
#
#Copyright (C) %YEAR% %USER%
#
#Follow Me!
#  github: github.com/onurozuduru
###############################################################################


### Functions

print_help() {
##TODO I am a template! Modify the below line!
    echo "Usage: $0 [ -x ARG1 ] [-hb]"
##TODO I am a template! Modify the below line!
    echo ""                                   #Definition of the script
##TODO I am a template! Modify the below lines!
    echo -e "-h,\t--help\tDisplay help."
    echo -e "-x,\t--xx\tDo something with ARG1." #double dash arg
    echo -e "-b,\t\tDo something."               #single dash arg
}

##TODO I am a template! Modify the below lines!
main() {
    echo "Do something!"
}


### Get params
# -l long options (--help)
# -o short options (-h)
# : options takes argument (--option1 arg1)
# $@ pass all command line parameters.
##TODO I am a template! Modify the below line!
params=$(getopt -l "help,xx:" -o "hx:b" -- "$@")

eval set -- "$params"

### Run
while true
do
    case $1 in
        -h|--help)
            print_help
            exit 0
            ;;
        -x|--xx)
            shift
            echo "Arg for X: $1"
            ;;
        -b)
            echo "-b is given"
            ;;
        --)
            shift
            break;;
        *)
            print_help
            exit 0
            ;;
    esac
    shift
done

main

