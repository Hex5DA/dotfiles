" this is ripped straight from 
" <https://github.com/Shougo/dein.vim/>
set nocompatible

let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

let s:dein_base = '~/.cache/dein'
execute 'set runtimepath+=' .. s:dein_dir

call dein#begin(s:dein_base)
call dein#add(s:dein_dir)

" plugins go here
call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})

call dein#end()
  
if dein#check_install()
  call dein#install()
endif

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

filetype indent plugin on
if has('syntax')
  syntax on
endif

"set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set statusline=%f%=%=%p%%\ (%l\ @\ %c)

lua require("general")
lua require("colourscheme")
