" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Editing
Plug 'ervandew/supertab'            " Autocomplete
Plug 'tpope/vim-unimpaired'         " Shortcut to move lines like Sublime
Plug 'tpope/vim-commentary'         " Toggle comment
Plug 'tpope/vim-fugitive'           " Git wrapper

" Appearance
Plug 'itchyny/lightline.vim'        " Status bar
Plug 'NLKNguyen/papercolor-theme'

" Utils
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'             " Fuzzy finder
Plug 'tpope/vim-repeat'             " Make vim repeat better

" Linters
Plug 'w0rp/ale'                     " Async(!) wrapper for external linters

" Syntax
Plug 'fatih/vim-go'

call plug#end()

" ----------------------------------------------------------------------------
"   Configure My Plugins
" ----------------------------------------------------------------------------

" ColorScheme
set background=dark
colorscheme PaperColor

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" Lightline
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive' ],[ 'filename' ],[ 'readonly' ],[ 'modified' ]],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LLFugitive',
      \   'readonly': 'LLReadonly',
      \   'mode': 'LLMode'
      \ }
      \ }

function! LLMode()
  let fname = expand('%:t')
  return  lightline#mode() == 'NORMAL' ? 'NOM' :
        \ lightline#mode() == 'INSERT' ? 'INS' :
        \ lightline#mode() == 'VISUAL' ? 'VIS' :
        \ lightline#mode() == 'V-LINE' ? 'V-L' :
        \ lightline#mode() == 'V-BLOCK' ? 'V-B' :
        \ lightline#mode() == 'REPLACE' ? 'REP' :
        \ lightline#mode() == 'COMMAND' ? 'CMD' :
        \ lightline#mode() == 'SELECT' ? 'SEL' :
        \ lightline#mode() == 'S-LINE' ? 'S-L' :
        \ lightline#mode() == 'S-BLOCK' ? 'S-B' :
        \ lightline#mode() == 'TERMINAL' ? 'TERM' : lightline#mode()
endfunction

function! LLReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LLFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction


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
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <Leader>rg :Rg<Space>

" Use ripgrep with vimgrep
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
