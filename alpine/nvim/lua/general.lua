require'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "lua", "vim", "vimdoc", "c" },
    auto_install = true,
    highlight = {
    	enable = true,
    },
}

function run(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result
end
 
function dirty()
    local git = run("[ -d .git ] && echo '' || echo 'no'")
    if git:len() > 1 then
        return ""
    end

    local status = run("git status --porcelain 2> /dev/null")
    if status:len() > 0 then
        return "D"
    else
        return "C"
    end
end

-- \ WT:%{luaeval('dirty()')}
vim.o.statusline = "%f%=%= %{luaeval('dirty()')} %p%% (%l @ %c)"
