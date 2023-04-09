augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

let g:coq_settings = { 'auto_start': 'shut-up', 'clients': {'lsp' : {'resolve_timeout': 100}} }

lua require("plugins")
lua require("init")
lua require("postinit")

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

map <C-F> :FZF<CR>

