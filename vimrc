" ----------------------------------------------------------------------------
"   .vimrc                                                                {{{
" ----------------------------------------------------------------------------

" Allow vim to break compatibility with vi
set nocompatible " This must be first, because it changes other options

" }}}-------------------------------------------------------------------------
"   Plugin                                                                {{{
" ----------------------------------------------------------------------------

" Installing the Plug plugin manager, and all the plugins are included in this
" other file.
source $HOME/.vim/plug.vim

" }}}-------------------------------------------------------------------------
"   Base Options                                                          {{{
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

" }}}-------------------------------------------------------------------------
"   Visual                                                                {{{
" ----------------------------------------------------------------------------

" Control Area (May be superseded by vim-airline)
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
set visualbell              " Use a visual bell, don't beep!
set cursorline              " Highlight the current line
set number                  " Show line numbers
set wrap                    " Soft wrap at the window width
set linebreak               " Break the line on words
set textwidth=0             " Disable inserting EOL when wrapping 

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
set formatoptions=1

" Colors
syntax enable               " This has to come after colorcolumn in order to draw it.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16               " Allow color schemes to do bright colors without forcing bold on old terminal
else 
  set t_Co=256              " else enable 256 colors 
endif

" When completing, fill with the longest common string
" Auto select the first option
set completeopt=longest,menuone

" Printing options
"set printoptions=header:0,duplex:long,paper:letter,syntax:n
" header:0                  Do not print a header
" duplex:long (default)     Print on both sides (when possible), bind on long
" syntax:n                  Do not use syntax highlighting.

" }}}-------------------------------------------------------------------------
"   Style for terminal vim
" ----------------------------------------------------------------------------

set mouse+=a  " Add mouse support for 'all' modes, may require iTerm
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" }}}-------------------------------------------------------------------------
"   Search                                                                {{{
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

" }}}-------------------------------------------------------------------------
"   Tabs                                                                  {{{
" ----------------------------------------------------------------------------

set tabstop=2               " Show a tab as four spaces
set shiftwidth=2            " Reindent is also four spaces
set softtabstop=2           " When hit <tab> use four columns
set expandtab               " Create spaces when I type <tab>
set shiftround              " Round indent to multiple of 'shiftwidth'.
set autoindent              " Put my cursor in the right place when I start a new line
filetype plugin indent on   " Rely on file plugins to handle indenting

" }}}-------------------------------------------------------------------------
"   Custom commands                                                       {{{
" ----------------------------------------------------------------------------

" Edit the vimrc file
nmap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
nmap <silent> <Leader>ep :vsplit $HOME/.vim/plug.vim<CR>
nmap <silent> <Leader>et :vsplit $HOME/.tmux.conf<CR>
nmap <silent> <Leader>sv :source $MYVIMRC<CR>
nmap <silent> <Leader>sp :source $HOME/.vim/plug.vim<CR>

" Faster save/quite/close
nmap <silent> <Leader>w :update<CR>
nmap <silent> <Leader>q :quit<CR>
nmap <silent> <Leader>n :cnext<CR>
nmap <silent> <Leader>p :cprevious<CR>

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

" Move current window to the far left using full height
" nmap <silent> <Leader>h <C-w>H
" Move current window to the far right using full height
" nmap <silent> <Leader>l <C-w>L
" Move current window to the top using full width
" nmap <silent> <Leader>k <C-w>K
" Move current window to the bottom using full width
" nmap <silent> <Leader>j <C-w>J

nmap <silent> <Leader>d :YcmCompleter GoToDefinition<CR>

" Clear search highlights
nnoremap <leader><space> :nohlsearch<cr>

" Pretty Printing JSON using Python
nnoremap <leader>pp :%!python -m json.tool<cr>

" }}}-------------------------------------------------------------------------
"   Configure My Plugins                                                  {{{
" ----------------------------------------------------------------------------

" ColorScheme
set background=dark
colorscheme PaperColor
let g:lightline = { 'colorscheme': 'PaperColor' }

" Find cmd with ripgrep
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --ignore-case --no-ignore --hidden --follow --color=always --glob "!.git/*"'.shellescape(<f-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <Leader>rg :Rg<Space>

" Use ripgrep with vimgrep
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" }}}-------------------------------------------------------------------------
"   Custom filetypes                                                      {{{
" ----------------------------------------------------------------------------

" Auto detect filetype
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile ~/dotfiles/ssh/config set filetype=sshconfig
autocmd BufRead,BufNewFile *.git/config,.gitconfig,.gitmodules,gitconfig set ft=gitconfig
autocmd BufNewFile,BufRead .eslintrc set filetype=javascript
autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" }}}-------------------------------------------------------------------------
"   Custom mappings                                                       {{{
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

" }}}-------------------------------------------------------------------------
"   Undo, Backup and Swap file locations                                  {{{
" ----------------------------------------------------------------------------

" Don't leave .swp files everywhere. Put them in a central place
set directory=$HOME/.vim/swapdir//
set backupdir=$HOME/.vim/backupdir//
if exists('+undodir')
    set undodir=$HOME/.vim/undodir
    set undofile
endif

" }}}-------------------------------------------------------------------------
"   If there is a per-machine local .vimrc, source it here at the end     {{{
" ----------------------------------------------------------------------------

if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

" }}}-------------------------------------------------------------------------
"                                                                         {{{
" ----------------------------------------------------------------------------

set exrc
set secure
