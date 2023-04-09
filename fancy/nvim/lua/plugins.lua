vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  -- use "neovim/nvim-lspconfig"
  use "ms-jpq/coq_nvim"
  use "rmehri01/onenord.nvim"
  use "junegunn/fzf"
  use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }
end)
