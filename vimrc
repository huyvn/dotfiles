" ----------------------------------------------------------------------------
"   .vimrc
" ----------------------------------------------------------------------------

" Allow vim to break compatibility with vi
set nocompatible " This must be first, because it changes other options

" ----------------------------------------------------------------------------
"   Plugin
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob("$HOME/.vim/autoload/plug.vim"))
    " Ensure all needed directories exist  (Thanks @kapadiamush)
    execute 'mkdir -p $HOME/.vim/plugged'
    execute 'mkdir -p $HOME/.vim/autoload'
    " Download the actual plugin manager
    execute '!curl -fLo $HOME/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" ----------------------------------------------------------------------------
"   Base Options
" ----------------------------------------------------------------------------

" Set the leader key to <space> instead of \ because it's easier to reach
let mapleader = "\<Space>"
"set notimeout                  " Turn off the timeout for the leader key
                                " Seems to break `n` in normal mode, so
                                " I turned it off
set encoding=utf-8              " I generally want utf-8 encoding
set nohidden                    " Don't allow buffers to exist in the background
set ttyfast                     " Indicates a fast terminal connection
set backspace=indent,eol,start  " Allow backspaceing over autoindent, line breaks, starts of insert
set backupcopy=yes              " Fixes some node watching tools: http://stackoverflow.com/a/35583907/1263117
set shortmess+=I                " No welcome screen
set shortmess+=A                " No .swp warning
set history=1000                 " Remember the last 200 :ex commands
set secure                      " disable unsafe commands in local .vimrc files

" ----------------------------------------------------------------------------
"   Visual
" ----------------------------------------------------------------------------

" Control Area
set showcmd                 " Show (partial) command in the last line of the screen.
set wildmenu                " Command completion
set wildmode=list:longest   " List all matches and complete till longest common string
set laststatus=2            " The last window will have a status line always
set noshowmode              " Don't show the mode in the last line of the screen, lightline.vim takes care of it
set ruler                   " Show the line and column number of the cursor position, separated by a comma.
set lazyredraw              " Don't update the screen while executing macros/commands

" Make vim autocomplete case insensitive
if exists("&wildignorecase")
    set wildignorecase
endif

" Buffer Area Visuals
set scrolloff=5             " Minimal number of screen lines to keep above and below the cursor.
set cursorline              " Highlight the current line
set number                  " Show line numbers
set wrap                    " Soft wrap at the window width
set linebreak               " Break the line on words
set textwidth=0             " Disable inserting EOL when wrapping
" No beep no flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" show fold column, fold by markers
set foldcolumn=0            " Don't show the folding gutter/column
set foldmethod=indent       " Fold based on indentation
set foldlevelstart=20       " Open 20 levels of folding when I open a file

" Open folds under the following conditions
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump

" Highlight tabs and trailing spaces
set listchars=tab:▸\ ,trail:•
set list                    " Make whitespace characters visible

" Splits
set splitbelow              " Open new splits below
set splitright              " Open new vertical splits to the right

" Character meaning when present in 'formatoptions'
" ------ ---------------------------------------
" c Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q Allow formatting of comments with "gq".
" r Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" t Auto-wrap text using textwidth (does not apply to comments)
" n Recognize numbered lists
" 1 Don't break line after one-letter words
" a Automatically format paragraphs

" Turn off auto insert linebreak on long lines
" instead just wrap the line on display
set formatoptions=

" Colors
syntax enable               " This has to come after colorcolumn in order to draw it.
set t_Co=256                " enable 256 colors

" When completing, fill with the longest common string
" Auto select the first option
set completeopt=longest,menuone

" Using netrw as project drawer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

nmap <silent> <Leader>d :Vexplore<CR>

" ----------------------------------------------------------------------------
"   Style for terminal vim
" ----------------------------------------------------------------------------

set mouse+=a  " Add mouse support for 'all' modes, may require iTerm
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" ----------------------------------------------------------------------------
"   Search
" ----------------------------------------------------------------------------

set incsearch               " Show search results as we type
set showmatch               " Show matching brackets
set hlsearch                " Highlight search results

" Use regex for searches
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
set ignorecase              " Ignore case when searching
set smartcase               " Don't ignore case if we have a capital letter

" ----------------------------------------------------------------------------
"   Tabs
" ----------------------------------------------------------------------------

set tabstop=2               " Show a tab as two spaces
set shiftwidth=2            " Reindent is also two spaces
set softtabstop=2           " When hit <tab> use two columns
set expandtab               " Create spaces when I type <tab>
set shiftround              " Round indent to multiple of 'shiftwidth'.
set autoindent              " Put my cursor in the right place when I start a new line
filetype plugin indent on   " Rely on file plugins to handle indenting

" ----------------------------------------------------------------------------
"   Custom commands
" ----------------------------------------------------------------------------

" Edit the vimrc file
nmap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <Leader>ep :vsplit $HOME/.vim/plug.vim<CR>
nmap <silent> <Leader>sv :source $MYVIMRC<CR>
nmap <silent> <Leader>sp :source $HOME/.vim/plug.vim<CR>

" Faster save/quite/close
nmap <silent> <Leader>w :update<CR>
nmap <silent> <Leader>q :quit<CR>
nmap <silent> <Leader>n :cnext<CR>
nmap <silent> <Leader>p :cprevious<CR>

" Non-hassle copy paste
" Ctrl+c = Copy
" Ctrl+v = Paste
set pastetoggle=<F10>                   " Paste mode doesn't mess up your formatting
inoremap <C-v> <F10><C-r>+<F10>
vnoremap <C-c> "+y

" Function to trim trailing white space
" Make your own mappings
function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Trim trailing white space
nmap <silent> <Leader>t :call StripTrailingWhitespaces()<CR>

" Cd to the current file's directory
nnoremap <Leader>. :cd %:p:h<CR>:pwd<CR>

" Clear search highlights
nnoremap <leader><space> :nohlsearch<cr>

" Pretty Printing JSON using Python
nnoremap <leader>pp :%!python -m json.tool<cr>

" ----------------------------------------------------------------------------
"   Custom filetypes
" ----------------------------------------------------------------------------

" Auto detect filetype
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.git/config,.gitconfig,.gitmodules,gitconfig set ft=gitconfig
autocmd BufNewFile,BufRead .eslintrc set filetype=javascript
autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" ----------------------------------------------------------------------------
"   Custom mappings
" ----------------------------------------------------------------------------

" When pasting, refill the default register with what you just pasted
xnoremap p pgvy

" Repurpose arrow keys to navigating windows
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j

" To encourage the use of <C-[np]> instead of the arrow keys in ex mode, remap
" them to use <Up/Down> instead so that they will filter completions
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Navigate using displayed lines not actual lines
nnoremap j gj
nnoremap k gk

" Make Y consistent with D
nnoremap Y y$

" Reselect visual block after indent/outdent: http://vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Nobody ever uses "Ex" mode, and it's annoying to leave
noremap Q <nop>

" ----------------------------------------------------------------------------
"   Undo, Backup and Swap file locations
" ----------------------------------------------------------------------------

" Don't leave .swp files everywhere. Put them in a central place
if empty(glob("$HOME/.vim/swapdir"))
    execute 'mkdir -p $HOME/.vim/swapdir'
endif
if empty(glob("$HOME/.vim/backupdir"))
    execute 'mkdir -p $HOME/.vim/backupdir'
endif
if empty(glob("$HOME/.vim/undodir"))
    execute 'mkdir -p $HOME/.vim/undodir'
endif
set directory=$HOME/.vim/swapdir//
set backupdir=$HOME/.vim/backupdir//
set undodir=$HOME/.vim/undodir
set undofile

" ----------------------------------------------------------------------------
"   If there is a per-machine local .vimrc, source it here at the end
" ----------------------------------------------------------------------------

if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" ----------------------------------------------------------------------------
"   Load plugins and their configs
" ----------------------------------------------------------------------------

"  Plugins are configured in this other file
source $HOME/.vim/plug.vim

" ----------------------------------------------------------------------------
"
" ----------------------------------------------------------------------------
set exrc
set secure
