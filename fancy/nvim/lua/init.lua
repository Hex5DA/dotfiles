vim.lsp.start({
  name = 'rust',
  cmd = {'rust-analyzer'},
  root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]),
})  

local lsp = require "lspconfig"
local coq = require "coq"

lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())
