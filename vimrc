" Setup Vundle for handling plugins
set nocompatible
filetype off

" On Windows, change from ~/vimfiles to ~/.vim for plugins.
if has('win32') || has('win64')
    set runtimepath^=~/.vim
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage vundle.
Plugin 'gmarik/Vundle.vim'

" Bundles from github.
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'w0rp/ale'
Plugin 'Raimondi/delimitMate'
Plugin 'Shougo/echodoc'
"Plugin 'Shougo/deoplete.nvim'
"Plugin 'Shougo/neocomplete'
"Plugin 'SirVer/ultisnips'
"Plugin 'roxma/nvim-yarp'
"Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'moorereason/vim-markdownfmt'
Plugin 'othree/html5.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lifepillar/vim-solarized8'
" Plugins from vim-scripts.org (git mirror of vim.org).
"Plugin 'taglist.vim'
"Plugin 'Command-T'
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

" Allow unwritten buffer
set hidden

" Insert mode completion options
set completeopt=longest,menu,menuone
"set completeopt=menu,menuone

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
"   zc close
"   zo open
"   za toggle current
"   z[C,O,A] all folds
"   zR open all folds
set nofoldenable
set foldmethod=indent
set foldlevel=2
"" speed up syntax highlighting
" set nocursorcolumn
" set nocursorline
" syntax sync minlines=256
" set synmaxcol=300
" set re=1

set novisualbell "don't beep
set noerrorbells "don't beep

" Always have the sign column (aka gutter) to be on so there's not a
" visual shift when something shows is toggled on/off there.
set signcolumn=yes

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

" Disable highlighting matching parenthesis
"let loaded_matchparen = 1

" Shut off completion messages
"set shortmess+=c

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
nnoremap Q q     " capital Q to start/stop recording
nnoremap q <Nop> " turns off the q key
"map q: :q

" Jump to the matching braces/parans and highlight everything in between
"noremap % v%

" Key mappings in INSERT mode
imap ;; <Esc>
imap jk <Esc>
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-v> <C-o><S-p>
imap <C-u> <C-o>u
imap <C-c> <C-o>vgG

" Nerd tree toggle
nmap <F2> :NERDTreeToggle<CR>

" Use <F6> to delete trailing white space
:nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Use <F4> to toggle paste mode
set pastetoggle=<F4>

" use <F5> to toggle line numbers
nmap <silent> <F5> :set number!<CR>

" Build tags for current directory
"nmap <F9> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Bufexplorer plugin toggle
nmap <F7> <leader>be
nmap <F11> <leader>be

" Toggle tag list
nmap <F8> :TagbarToggle<cr>
nmap <F9> :TagbarOpen fj<cr>
nmap <F12> :TagbarToggle<cr>

" Close OmniComplete preview window after insert.
"if has('autocmd')
"    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"endif

" Make VIM work in Screen
if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0
    set t_co=256
endif

let &colorcolumn="80"
"hi Folded cterm=none ctermfg=Gray
"hi NonText cterm=none ctermbg=Black ctermfg=LightGrey

" Automatically resize screens to be equally the same
autocmd VimResized * wincmd =

" This maps the ENTER key to be like ctrl-y when selecting from the menu.
" ctrl-x ctrl-o will bring up the autocomplete menu again.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
"set t_Co=256

" *********** Plugin Settings ***********

" --- netRW: Open files in a split window ---
let g:netrw_browse_split = 1

" Solarized Theme ---
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
"colorscheme solarized

" --- Solarized8 ---
colorscheme solarized8

" --- SuperTab ---
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" --- Airline ---
let g:airline_theme='solarized'
"let g:airline_enable_tagbar=1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_symbols = get(g:,'airline_symbols',{})
let g:airline_powerline_fonts = 1
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.colnr = ' ℅:'
" remove separators
"let g:airline_left_sep=' '
"let g:airline_right_sep=' '
"let g:airline_detect_whitespace=0
let g:airline#extensions#whitespace#enabled = 1

" Limit Emmet Plugin to just HTLM and CSS files.
let g:user_emmet_install_globals = 0
autocmd FileType html,css EmmetInstall

"" --- NeoComplete ---
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_auto_close_preview = 0

"" --- deocomplete ---
""let g:deoplete#enable_at_startup = 1
""instruct deoplete to use omni completion for go files
""call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" --- vim-go settings ---
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_debug_breakpoint_sign_text = 0
let g:go_auto_sameids = 0
let g:go_template_autocreate = 0  " turn off inserting skeleton template with new files.
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_debug = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 0
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_structs = 0
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" vim-godef settings
"let g:godef_split=2
"let g:godef_same_file_in_same_window=1

" --- Tagbar settings ---
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

" --- Markdown settings ---
au BufRead,BufNewFile *.md setlocal textwidth=80
let g:markdownfmt_command = 'markdownfmt'
let g:markdownfmt_autosave=0
au FileType markdown nmap <leader>md :<C-u>call markdownfmt#Format()<CR>

" --- Ale ---
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1  "Enable integration with airline.

if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

" --- Echodoc ---
" To use echodoc, you must increase 'cmdheight' value.
"set cmdheight=2
"let g:echodoc_enable_at_startup = 1

" **************************************************
" *         Language Specific Settings             *
" **************************************************

" Strip out trailing white spaces for certain files
autocmd FileType vim,c,cpp,java,php,textpb,markdown,html autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd BufWritePre *.py,*.md,*.pp,*.py,*.js,*.html,*.sdl,*.proto :%s/\s+$//e

" Treat .template files as html files
au BufNewFile,BufRead *.template set filetype=html
" html and template files doesn't need the 80 column limit
autocmd BufNewFile,BufRead *.html,*.template setlocal textwidth=300

" ======= Golang Specific Stuff =======
"filetype off
"filetype plugin indent off
"set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
"syntax on
"au FileType go au BufWritePre <buffer> Fmt

" dif - 'd'eletes the function body (between the {}). yif - 'y'anks the body
" content.
" daf - 'd'eletes the whole function.
" ]] jumps to next function (also accepts counts such as 5]] or v]])
" [[ jumps to previous function (also accepts counts such as 5[[ or v[[)
" ctrl-x ctrl-o auto-completes
"
" :GoSameIds highlights all the matching identifiers (e.g. vars, func)
" :GoSameIdsClear clear highlights

" :GoFiles lists all the files for the package
" :GoDeps shows the dependency of the file

" ***Guru commands***
" :GoDescribe       Like :GoInfo but more detailed.
" :GoImplements     Gives what interface it implements.
" :GoWhicherrs      Shows possible err value.
" :GoChannelPeers   Shows the allocation of a channel and where it's
"                   sending/receiving from.
" :GoCallee         Lists all the functions called.
" :GoCaller         Lists all the caller of the function.
" :GoCallStack      shows arbitray path from root to function.


" Commands to run Go tools from VIM
if has('autocmd')
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal shiftwidth=4
    au Filetype go set noshowmode
    au FileType go nmap <leader>gr <Plug>(go-run)
    au FileType go nmap <leader>gb <Plug>(go-build)
    au FileType go nmap <leader>gt <Plug>(go-test)
    au FileType go nmap <leader>gc <Plug>(go-coverage)

    " <leader>gd or ctrl-] jumps to definition by default then use ctrl-t
    " jumps back to the previous location (instead of ctrl-o)

    " Jump to the function definition in a new vertical split window
    au FileType go nmap <Leader>ds <Plug>(go-def-split)

    " Show the function signature in the status line
    au FileType go nmap <Leader>gi <Plug>(go-info)
    " Show function signature in the status
    au FileType go map <F3> %:GoInfo<CR><C-o>
    " Jump out of insert mode to run GoInfo to show signature in the status
    au FileType go inoremap <F3> <C-o>%<C-o>:GoInfo<CR><C-o><C-o>

    " Show the full documentation for function
    au FileType go nmap <Leader>gf <Plug>(go-doc)

    " Bring up the browser window with the right godoc.org page
    au FileType go nmap <Leader>godoc <Plug>(go-doc-browser)

    " Shows all types and function declaration to do quick fuzzy search of
    " current file
    au FileType go nmap <Leader>gz :GoDecls<CR>

    " Like :GoDecls but searches the directory
    au FileType go nmap <leader>gp :GoDeclsDir<cr>

    " Toggle between foo.go and foo_test.go
    au FileType go nmap <leader>ga :GoAlternate<cr>

    " Code folding settings for Go
    au FileType go set foldmethod=syntax
    au FileType go set foldlevel=0

    " Have autocomplete pop-up when with '.' is pressed.
    au FileType go inoremap <buffer> . .<C-x><C-o>
endif
