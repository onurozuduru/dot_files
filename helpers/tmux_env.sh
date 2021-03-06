#!/bin/sh
###############################################################################
#File: tmux_env.sh
#
#License: MIT
#
#Copyright (C) 2021 Onur Ozuduru
#
#Follow Me!
#  github: github.com/onurozuduru
###############################################################################

### Constants

WORKSPACE=$(pwd)
SESSION="TmuxEnv"
WIN_MAIN="$SESSION:0.0"
WIN_SECOND="$SESSION:0.1"
SPLIT_RATIO="-p 25" #in %
SPLIT_ORIENTATION="-v"


### Functions

print_help() {
    echo "Usage: $0 [ -w | --workspace <path> ] [ -V | -H | -N ] [ -r | --ratio <percentage> ] [ -h | --help ]"
    echo "Run tmux environment with one window that could split in vertically or horizontally as desired."
    echo "\t-h,--help\tDisplay help."
    echo "\t-w,--workspace\tLocation to go in tmux window. Default: current directory."
    echo "\t-V\t\tVertical split."
    echo "\t-H\t\tHorizontal split. *Default mode!"
    echo "\t-N\t\tNo split."
    echo "\t-r,--ratio\tSplit ratio (if -V or -H is given). Uses percentage (%) as unit. Default: 25"
    echo "Default: $0 -w $(pwd) -H -r 25"
}

start_tmux() {
    tmux new -s $SESSION -d
    if [ $? -eq 0 ]; then
        if [ ! -z $WIN_SECOND ]; then
            tmux split-window -t $SESSION $SPLIT_ORIENTATION $SPLIT_RATIO
            tmux send-keys -t $WIN_SECOND "cd $WORKSPACE && clear" Enter
        fi
        tmux send-keys -t $WIN_MAIN "cd $WORKSPACE" Enter
        tmux select-pane -t $WIN_MAIN
    fi
    tmux attach -t $SESSION
}

### Get params
# -l long options (--help)
# -o short options (-h)
# : options takes argument (--option1 arg1)
# $@ pass all command line parameters.
params=$(getopt -l "help,workspace:,ratio:" -o "hw:r:HVN" -- "$@")

eval set -- "$params"

### Run
while true
do
    case $1 in
        -h|--help)
            print_help
            exit 0
            ;;
        -w|--workspace)
            shift
            WORKSPACE=$1
            ;;
        -r|--ratio)
            shift
            SPLIT_RATIO=$1
            SPLIT_RATIO="-p $SPLIT_RATIO"
            ;;
        -V)
            SPLIT_ORIENTATION="-h"
            ;;
        -H)
            SPLIT_ORIENTATION="-v"
            ;;
        -N)
            SPLIT_ORIENTATION=""
            SPLIT_RATIO=""
            WIN_SECOND=""
            WIN_MAIN="$SESSION:0"
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

start_tmux

