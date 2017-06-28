" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Install vim-plug if we don't already have it
if empty(glob("~/.vim/autoload/plug.vim"))
    " Ensure all needed directories exist  (Thanks @kapadiamush)
    execute 'mkdir -p ~/.vim/plugged'
    execute 'mkdir -p ~/.vim/autoload'
    " Download the actual plugin manager
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Editing
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neocomplete.vim'

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'NLKNguyen/papercolor-theme'

" Utils
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Linters
Plug 'w0rp/ale'

" Syntax
Plug 'fatih/vim-go'

filetype plugin indent on                   " required!
call plug#end()
