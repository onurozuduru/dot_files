" Vim configuration
"
" Tuned for c++ development. Requires python language server for
" auto complete features. Please install it by
"
" sudo apt-get install python-pip
" sudo pip install --upgrade python-language-server
"
" To install plugins, open vim and run :PlugInstall
"
set nocompatible              " be iMproved, required
filetype off                  " required

" Automatic installation of vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins {{{
call plug#begin('~/.config/nvim/plugged')
"
Plug 'tpope/vim-pathogen'
" Detector for wrong style indentations
Plug 'ciaranm/detectindent'
" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Vim templates support
Plug 'aperezdc/vim-template'
" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" Cheat sheets
Plug 'dbeniamine/cheat.sh-vim'
" Netwr enchancement
Plug 'tpope/vim-vinegar'
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Cmake building
Plug 'vhdirk/vim-cmake'
" Easy commenting
Plug 'tpope/vim-commentary'
" Autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
" Async execution
Plug 'shougo/vimproc', { 'do': 'make' }
" Cool statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Doxygen
Plug 'vim-scripts/doxygentoolkit.vim', { 'for': 'cpp' }
" Switch between declaration and definition
Plug 'vim-scripts/a.vim'
" Buffer explorer
Plug 'jlanzarotta/bufexplorer'
" Syntax higlighting
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" Surround handling
Plug 'tpope/vim-surround'
" Allow repeat for plugins
Plug 'tpope/vim-repeat'
" Latex
Plug 'lervag/vimtex'
Plug 'Konfekt/FastFold'
Plug 'matze/vim-tex-fold'
" Nice colors
Plug 'sts10/vim-pink-moon'
" Conque GDB
" Plug 'vim-scripts/Conque-GDB'
" Explorer
Plug 'preservim/nerdtree'
" Go plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug  'wellle/targets.vim'
" Highlight for DockerFile
Plug 'ekalinin/Dockerfile.vim'
" Highlight xml/html tag
Plug 'gregsexton/matchtag'
call plug#end()            " required
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set colorscheme to solarized {{{
syntax enable
set background=dark
if $SSH_CONNECTION
    let g:solarized_termtrans=0
    let g:solarized_termcolors=256
endif

colorscheme pink-moon
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings {{{
" Set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" Use indentation of previous line
set autoindent
" Use intelligent indentation for C
set smartindent
" Configure tab width and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
"
" Highlight if exceeds 120
augroup vimrc_autocmds
    autocmd!
    autocmd VimEnter,WinEnter * silent! let w:m1=matchadd('ColorColumn', '\%>120v.\+',-1)
augroup END
"
set backspace=indent,eol,start  " Delete over line breaks
set whichwrap+=<,>,h,l
set laststatus=2                " Always display the status line
set lazyredraw                  " Use lazy redrawing
set ruler                       " Show ruler
set showcmd                     " Show current command
set showmatch                   " Show matching bracket/parenthesis/etc
set showmode                    " Show current mode
" Temp Files
set nobackup                    " No backup file
set noswapfile                  " No swap file
" show line number
set number
" Mouse
set mousehide                   " Hide mouse when typing
" Set mouse=nicr                " Disable mouse
set mouse=a
set ttyfast
" Disable bell
set visualbell                  " Disable visual bell
set noerrorbells                " Disable error bell
" Change buffer without saving
set hid
" Regex support with magic
set magic
" Spell checking
set spelllang=en_us             " English as default language
set spell                       " Enable by default
"
" Disable highlight for rare words
hi clear SpellRare
" Setup underline options for spell checker
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl
"
" Search options
set ignorecase
set smartcase
set incsearch   " Do incremental searching
set hlsearch
" Wordwrap
set nowrap
set sidescroll=15
set listchars+=precedes:<,extends:>
set tags+=~/.config/nvim/tags/cpp;./tags;/.     " Recursively search tags from current directory
set autoread                                    " Auto read when a file is changed from the outside
" Key sequence timeout
set ttimeout                        " Enable time out
set ttimeoutlen=0                   " Disable key code delay
set mat=2
" Scroll
set sidescrolloff=3                 " Keep at least 3 lines left/right
set scrolloff=3                     " Keep at least 3 lines above/below
" History
set history=1000                    " Remember more commands
if has('persistent_undo')
    set undofile                    " Persistent undo
    set undodir=~/.config/nvim/undo " Location to store undo history
    set undolevels=1000             " Max number of changes
    set undoreload=10000            " Max lines to save for undo on a buffer reload
endif
" misc
set title
"
" Set bracket highlighting
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Correct some spelling mistakes {{{
ia teh      the
ia htis     this
ia tihs     this
ia funciton function
ia fucntion function
ia funtion  function
ia retunr   return
ia reutrn   return
ia sefl     self
ia eslf     self
ia viod     void
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove extra whitespace automatically {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd FileType netrw setl bufhidden=wipe
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set airline {{{
let g:airline_theme='atomic'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#formatter='unique_tail'
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw settings {{{
let g:netrw_preview=1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternate settings {{{
let g:alternateSearchPath='reg:|src/\([^/]*\)|inc/\1||,reg:|inc/\([^/]*\)|src/\1||,sfr:../source,sfr:../src,sfr:../include,sfr:../inc'
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Template settings {{{
let g:templates_no_autocmd=1
let g:templates_directory=['~/.config/nvim/templates']
let g:templates_global_name_prefix='tpl'
let g:username='Onur Ozuduru'
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clang format settings {{{
let g:clang_format#detect_style_file=1
let g:clang_format#auto_format=1
let g:clang_format#auto_format_on_insert_leave=1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete for YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf='~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='▲'
let g:ycm_autoclose_preview_window_after_completion=1
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF settings {{{
"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'yoffset': 0.9, 'highlight': 'Comment', 'border': 'rounded' } }
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--preview',
                \'batcat --style=numbers --color=always --line-range :500 {}']}), <bang>0)
" Hidden files
command! -bang -nargs=? -complete=dir HFiles
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'rg --files --hidden --follow --glob "!.git/*"',
                \'options': ['--preview', 'batcat --style=numbers --color=always --line-range :500 {}']}), <bang>0)
"
let g:fzf_nvim_statusline = 0 " disable status line overwriting
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag -g ""'
    let g:ackprg = 'ag --vimgrep'
endif
let $FZF_DEFAULT_OPTS .= ' --bind=up:preview-up,down:preview-down'
"
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Settings {{{
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto close brackets {{{
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap () ()<left>
inoremap [ []<left>
inoremap [] []<left>
inoremap { {}<left>
inoremap {} {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings {{{
"
" Completer Keys
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jj :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jg :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jgg :YcmCompleter GoToImprecise<CR>
nnoremap <leader>jk :YcmCompleter GoToInclude<CR>
"
" Fix tabs on new line
inoremap <C-Return> <CR><CR><C-o>k<Tab>
"
" Copy file path
noremap <leader>yf :let @" = expand("%:p")<CR>:echo "File path copied!"<CR>
noremap <leader>yff :let @+ = expand("%:p")<CR>:echo "File path copied to clipboard!"<CR>
"
" Add newline from normal mode
nmap <C-S> o<Esc>k<CR>
"
" Buffer resizing
map <silent> <S-h> <C-W>10<
map <silent> <S-j> <C-W>10-
map <silent> <S-k> <C-W>10+
map <silent> <S-l> <C-W>10>
"
" Fast editing of the .vimrc
map <leader>e :e! $MYVIMRC<CR>
"
" No highlight for searches
map <silent> <leader><cr> :noh<cr>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F1 - F12 {{{
" Explore
map <silent> <F2> <Esc><Esc>:call ToggleExplore()<CR><CR>
" Go to tag location
map <silent> <F3> <C-]>
" BufExplorer toggle
map <silent> <F4>  <Esc><Esc>:ToggleBufExplorer<CR>
" Open document preview under cursor
map <silent> <F6> :YcmCompleter GetDoc<CR>
" Quickfix toggle
map <silent> <F9> :YcmCompleter FixIt<CR>
" F10 and F11 cannot be used, clashing with Ubuntu shortcuts.
map <F12> :!bash $HOME/.config/nvim/tags/generate_tags.sh -d . -i "build docs"<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helpful when learning Vim {{{
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts for system clipboard {{{
" Copy to X CLIPBOARD
map <silent> <leader>cc :w !xsel -i -b<CR><CR>
map <silent> <leader>cp :w !xsel -i -p<CR><CR>
map <silent> <leader>cs :w !xsel -i -s<CR><CR>
" Paste from X CLIPBOARD
map <silent> <leader>pp :r!xsel -p<CR><CR>
map <silent> <leader>ps :r!xsel -s<CR><CR>
map <silent> <leader>pb :r!xsel -b<CR><CR>
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoformat settings {{{
augroup autoformat_settings
    autocmd FileType c,cpp,hpp,h,proto,javascript,java AutoFormatBuffer clang-format
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd Filetype ptyhon AutoFormatBuffer autopep8
augroup END
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands {{{
autocmd BufWritePre * %s/\s\+$//e
augroup filtypes
    autocmd!
    autocmd FileType c,cpp setlocal comments^=:///
    autocmd FileType c,cpp setlocal commentstring=///\ %s
    autocmd FileType crontab setlocal nobackup nowritebackup
augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Number toggle {{{
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing whitespace {{{
augroup remove_trailing_whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reload vimrc {{{
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Vexplore {{{
function! ToggleExplore()
    if &ft ==# "netrw"
        execute "Rexplore"
        execute "q"
    else
        execute "Vexplore"
    endif
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby settings {{{
autocmd FileType ruby set shiftwidth=2
augroup filetypedetect
    autocmd BufNewFile,BufRead *.yml setf eruby
augroup END
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl settings {{{
autocmd FileType perl set shiftwidth=2
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tex settings {{{
let g:tex_flavor="latex"
autocmd FileType tex set shiftwidth=4
autocmd FileType tex set wrap linebreak
autocmd FileType tex let g:tex_conceal=''
autocmd FileType tex let g:vimtex_fold_manual=1
autocmd FileType tex let g:vimtex_latexmk_continuous=1
autocmd FileType tex let g:vimtex_compiler_progname='nvr'
autocmd FileType tex let g:vimtex_view_method='evince'
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers={}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown settings {{{
au BufRead,BufNewFile *.md setlocal textwidth=80
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Java-Script settings {{{
au FileType javascript call JavaScriptSettings()
function! JavaScriptSettings()
    setl nocindent
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python settings {{{
au FileType python call PythonSettings()
function! PythonSettings()
    set nocindent
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    "autocmd BufWrite *.py :call DeleteTrailingWS()
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bitbake settings {{{
au FileType bitbake call BibakeSettings()
function! BibakeSettings()
    set nocindent
    "autocmd BufWrite *.bb :call DeleteTrailingWS()
    "autocmd BufWrite *.bbclass :call DeleteTrailingWS()
    "autocmd BufWrite *.bbappend :call DeleteTrailingWS()
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash settings {{{
autocmd BufRead,BufNewFile *.sh,*.bash,.bashrc,.bash_aliases,.bash_functions call BashSettings()
function! BashSettings()
    set syntax=sh
    setl expandtab
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CMake settings {{{
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in call CMakeSettings()
function! CMakeSettings()
    setl expandtab
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust settings {{{
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust compiler cargo
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makefile settings {{{
au FileType make setl noexpandtab   " use real tabs
au FileType make setl shiftwidth=8  " standard shift width
au FileType make setl tabstop=8     " use standard tab size
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Binary file setting {{{
augroup Binary " vim -b : edit binary using xxd-format!
    au!
    au BufReadPre  *.tgz,*.BIN,*.bin,*.img let &bin=1
    au BufReadPost *.tgz,*.BIN,*.bin,*.img if &bin | %!xxd
    au BufReadPost *.tgz,*.BIN,*.bin,*.img set ft=xxd | endif
    au BufWritePre *.tgz,*.BIN,*.bin,*.img if &bin | %!xxd -r
    au BufWritePre *.tgz,*.BIN,*.bin,*.img endif
    au BufWritePost *.tgz,*.BIN,*.bin,*.img if &bin | %!xxd
    au BufWritePost *.tgz,*.BIN,*.bin,*.img set nomod | endif
augroup END
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text/Log file settings {{{
au BufRead,BufNewFile *.txt,*.log,*.Log set wrap linebreak
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim file settings {{{
" Set folding for marker
au FileType vim setlocal foldmethod=marker
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Xml settings {{{
autocmd BufRead,BufNewFile *.xml call XmlSettings()
function! XmlSettings()
    set syntax=xml
    setl expandtab
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
endfunction
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
