" Install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install Vim Plug Plugins 
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
call plug#end()

" turn hybrid line numbers on
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

:set tabstop=4

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


set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=%{TabStopStatus()}
set statusline+=\ %y
set statusline+=\ %l/%L:%c
set statusline+=\ 

" tab -> spaces
set expandtab
set tabstop=4
  " a tab is 4 spaces
set softtabstop=4   " tab size when insterting/pasting
set shiftwidth=4    " number of spaces to use for autoindenting
set shiftround
 " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab
   " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent
 " always set autoindenting on
set copyindent
 " copy the previous indentation on autoindenting
