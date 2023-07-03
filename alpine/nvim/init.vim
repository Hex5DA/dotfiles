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
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('nvim-lua/plenary.nvim')

" completion (._.)
call dein#add('neovim/nvim-lspconfig')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('hrsh7th/cmp-buffer')
call dein#add('SirVer/ultisnips')

call dein#end()
  
if dein#check_install()
  call dein#install()
endif

set statusline=%f%=%=\ %p%%\ (%l\ @\ %c)
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber

filetype indent plugin on
if has('syntax')
  syntax on
endif

let mapleader = "\<space>"
noremap <Leader>f <cmd>Telescope find_files<cr>
noremap <Leader>F <cmd>Telescope oldfiles<cr>
noremap <Leader>g <cmd>Telescope treesitter<cr>
noremap <Leader>h <cmd>Telescope live_grep<cr>
noremap <C-f> <cmd>lua vim.lsp.buf.format()<cr>

lua require("colourscheme")
lua require("general")

if argc() == 0
  lua require("startup")
endif
