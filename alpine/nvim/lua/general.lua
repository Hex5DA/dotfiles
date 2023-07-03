require'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "lua", "vim", "vimdoc", "c", "html" },
    auto_install = true,
    highlight = {
    	enable = true,
    },
}

local lspconfig = require"lspconfig"
lspconfig.rust_analyzer.setup {}
lspconfig.tsserver.setup {}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" }
    }, {
        { name = "buffer" }
    }),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig["rust_analyzer"].setup { capabilities = capabilities }
