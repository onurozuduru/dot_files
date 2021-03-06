# Goes up a specified number of directories  (e.g. up 4)
up () {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
        do
            d=$d/..
        done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# Extract any archive
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Search in current directory or given directory (given directory can be relative to current directory)
# -a flag to include hidden directories
nvimfzf () {
    local search_all=""
    local search_path=$(pwd)

    if [ -n "$1" ]; then
        if [ "$1" = "-a" ]; then
            search_all="YES"
        fi

        if [ -z "$search_all" ]; then
            search_path="$1"
        else
            if [ -n "$2" ]; then
                search_path="$2"
            fi
        fi
    fi

    if [ -n "$search_all" ]; then
        nvim $(find "$search_path" | fzf --height 40% --layout reverse --info inline --border \
            --preview 'batcat --style=numbers --color=always --line-range :500 {}' \
            --preview-window right:noborder --color \
            'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899' \
            --bind 'shift-up:preview-up,shift-down:preview-down')
    else
        nvim $(find "$search_path" -not -path '*/\.*' | fzf --height 40% --layout reverse --info inline --border \
            --preview 'batcat --style=numbers --color=always --line-range :500 {}' \
            --preview-window right:noborder --color \
            'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899' \
            --bind 'shift-up:preview-up,shift-down:preview-down')
    fi
}

# Search and open files with default application
open() {
    local search_path=$(pwd)
    if [ -n "$1" ]; then
        search_path="$1"
    fi
    local file=$(find "$search_path" -not -path '*/\.*' | fzf --height 40% --layout reverse --info inline --border \
        --preview 'batcat --style=numbers --color=always --line-range :500 {}' \
        --preview-window right:noborder --color \
        'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899' \
        --bind 'shift-up:preview-up,shift-down:preview-down')
    if [ -n "$file" ]; then
        xdg-open "$file"
    fi
}
