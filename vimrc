" Setup Vundle for handling plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage vundle.
Plugin 'gmarik/Vundle.vim'

" Bundles from github.
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ervandew/supertab'
" Plugins from vim-scripts.org (git mirror of vim.org).
Plugin 'taglist.vim'
Plugin 'bufkill.vim'
Plugin 'Command-T'
"Bundles from non github repos.
" None

call vundle#end()
" ----- End Vundle Setup -----

" Enable loading filetype and indentation plugins
filetype plugin on
filetype indent on

" Turn syntax highlighting on
syntax on

" turn on line number
set number

" Write contents of the file, if it has been modified, on buffer exit
set autowrite

" Allow backspacing over everything
set backspace=indent,eol,start

" Set the split window to be the bottom (useful for preview)
set splitbelow

" Insert mode completion options
set completeopt=menu,longest,preview

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Remember up to 100 'colon' commmands and search patterns
set history=100

" Enable incremental search
set incsearch

" Always show status line, even for one window
set laststatus=2

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Don't highlight results of a search
set nohlsearch

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Don't request terminal version string (for xterm)
set t_RV=

" Use 4 spaces for <Tab> and :retab
set tabstop=4

" Use spaces for <Tab> and :retab
set expandtab

" Write swap file to disk after every 50 characters
set updatecount=50

" case-sensative search
set ignorecase

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.viminfo

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" Enable folding but do not fold code by default
set foldenable 
set foldmethod=indent
set foldlevel=100 

set novisualbell "don't beep
set noerrorbells "don't beep

" Have VIM recursively search upward for tag file
set tags=tags;/

" Go back to the position the cursor was on the last time this file was edited
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif
endif

" Change to directory current working file
if has("autocmd")
    au BufEnter * lcd %:p:h
endif

" Fix my <Backspace> key (in Mac OS X Terminal)
set t_kb=
fixdel

" Avoid loading MatchParen plugin
let loaded_matchparen = 1

" netRW: Open files in a split window
let g:netrw_browse_split = 1

" Use <space> as the leader - need the noop before let mapleader
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

" Disable arrow keys to force learn HJLK
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Quickly edit/reload vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" <Space>w to save a file
nnoremap <Leader>w :w<CR>

" Stop the stupid record window that I never use
map q: :q

" Jump to the matching braces/parans and highlight everything in between
noremap % v%

" Key mappings in INSERT mode
imap ;; <Esc>
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-v> <C-o><S-p>
imap <C-u> <C-o>u
imap <C-c> <C-o>vgG

" use <F6> to toggle line numbers
nmap <silent> <F6> :set number!<CR>

" Nerd tree toggle
nmap <F2> :NERDTreeToggle<CR>

" Build tags for current directory
"nmap <F9> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Bufexplorer plugin toggle
nmap <F7> <leader>be
nmap <F11> <leader>be

" Toggle tag list
nmap <F8> :TagbarToggle<cr>
nmap <F12> :TagbarToggle<cr>

" Close OmniComplete preview window after insert.
if has('autocmd')
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

" Make VIM work in Screen
if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0
    set t_co=256
endif

if !has('gui_running')
    "Compatibility for Terminal"
    let g:solarized_termtrans=1
    if (&t_Co >= 256 || $TERM == 'xterm-256color')
        let g:solarized_termcolors=256
    else
        " Make Solarized use 16 colors for Terminal support
        let g:solarized_termcolors=16
    endif
endif

set background=dark
colorscheme solarized
let &colorcolumn="80"
hi Folded cterm=none ctermfg=Gray
hi NonText cterm=none ctermbg=Black ctermfg=LightGrey

" *********** Plugin Settings *********** 
" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Airline Plugin configuration
"let g:airline_theme='solarized'
"let g:airline_enable_tagbar=1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_powerline_fonts = 1
" remove separators
"let g:airline_left_sep=' '
"let g:airline_right_sep=' '
"let g:airline_detect_whitespace=0
let g:airline#extensions#whitespace#enabled = 1
" Limit Emmet Plugin to just HTLM and CSS files.
let g:user_emmet_install_globals = 0
autocmd FileType html,css EmmetInstall

" *********** Language Specific Settings ***********  

" Strip out trailing white spaces for certain files
autocmd BufWritePre *.py,*.js,*.html :%s/\s\+$//e

" Treat .template files as html files
au BufNewFile,BufRead *.template set filetype=html
" html and template files doesn't need the 80 column limit
autocmd BufNewFile,BufRead *.html,*.template setlocal textwidth=300

" Golang Specific Stuff
"filetype off
"filetype plugin indent off
"set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
"syntax on
"au FileType go au BufWritePre <buffer> Fmt
if has('autocmd')
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal shiftwidth=4
endif

" vim-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_fmt_command = "goimports"

" Commands to run Go tools from VIM
if has('autocmd')
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    au FileType go nmap <Leader>ds <Plug>(go-def-split) 
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>doc <Plug>(go-doc)
    au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
endif

" vim-godef settings
"let g:godef_split=2
"let g:godef_same_file_in_same_window=1

" tagbar settings
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


