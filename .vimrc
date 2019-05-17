" Install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install Vim Plug Plugins
call plug#begin('~/.vim/plugged')

" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
Plug 'sgur/vim-editorconfig'
call plug#end()

" turn hybrid line numbers on
:set number relativenumber
highlight LineNr ctermfg=NONE ctermbg=NONE

" statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Generate a statusline flag for expandtab.
function! ExpandTabFlag()
  if &expandtab == 0
    return "Tab Size:"
  else
    return "Spaces:"
  endif
endfunction

" Generate statusline flags for softtabstop, tabstop, and shiftwidth.
function! TabStopStatus()
    let str = ExpandTabFlag()  . &tabstop
  " Show softtabstop or shiftwidth if not equal tabstop
  if   (&softtabstop && (&softtabstop != &tabstop))
  \ || (&shiftwidth  && (&shiftwidth  != &tabstop))
    let str = "TS:" . &tabstop
    if &softtabstop
      let str = str . "\ STS:" . &softtabstop
    endif
    if &shiftwidth != &tabstop
      let str = str . "\ SW:" . &shiftwidth
    endif
  endif
  return str
endfunction

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
set t_Co=256
set laststatus=2
set statusline=
set statusline+=\ %<%F%m%r%h%w\ 
set statusline+=%{StatuslineGit()}
set statusline+=%=
set statusline+=%{TabStopStatus()}
set statusline+=\ %y
set statusline+=\ %l/%L:%c
set statusline+=\ 

highlight StatusLine cterm=none  ctermfg=240 ctermbg=253
highlight StatusLineNC cterm=none ctermfg=245 ctermbg=254
" tab -> spaces
set expandtab
" a tab is 4 spaces
set tabstop=4
set softtabstop=4   " tab size when insterting/pasting
set shiftwidth=4    " number of spaces to use for autoindenting
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" always set autoindenting on
set autoindent
" copy the previous indentation on autoindenting
set copyindent

" show tabs and spaces
set list
set listchars=eol:¬,tab:->,space:·
highlight SpecialKey ctermfg=240

"remove vertical split col
set fillchars+=vert:\ 
highlight VertSplit cterm=none ctermfg=white ctermbg=none

