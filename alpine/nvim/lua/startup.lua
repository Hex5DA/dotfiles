-- large parts of this script are based off of - or taken verbatim - this plugin
-- <https://github.com/amirrezaask/start.nvim>
-- any modifications i have made (notably: the gradient) are licensed under MIT where applicable
-- credit to the original autor where due.

local text = [[
                              _                 
        _ __   ___  _____   _(_)_ __ ___        
       | '_ \ / _ \/ _ \ \ / / | '_ ` _ \       
       | | | |  __/ (_) \ V /| | | | | | |      
       |_| |_|\___|\___/ \_/ |_|_| |_| |_|      
           ___       ____  ____    _            
          / _ \__  _| ___||  _ \  / \           
  _____  | | | \ \/ /___ \| | | |/ _ \    _____ 
 |_____| | |_| |>  < ___) | |_| / ___ \  |_____|
          \___//_/\_\____/|____/_/   \_\        
]]

local function multiline_string_to_table(src)
    local tab = {}
    local start = 0

    for i = 1, src:len() do
        local ch = string.sub(src, i, i)
        if ch == "\n" then
            local line = string.sub(src, start, i - 1)
            table.insert(tab, line)
            start = i + 1
        end
    end

    return tab
end

-- these functions are taken from this helpful thread
-- <https://stackoverflow.com/a/35191214>
local function to_hex(dec)
    local hex = string.format("%X", dec)
    if dec < 16 then
        hex = "0" .. hex
    end

    return hex
end

local function blend_hex(from, to, by)
    local r1, g1, b1 = string.sub(from, 2, 3), string.sub(from, 4, 5), string.sub(from, 6, 7)
    local r2, g2, b2 = string.sub(to, 2, 3), string.sub(to, 4, 5), string.sub(to, 6, 7)
    r3 = tonumber(r1, 16) * (100 - by) / 100.0 + tonumber(r2, 16) * by / 100.0
    g3 = tonumber(g1, 16) * (100 - by) / 100.0 + tonumber(g2, 16) * by / 100.0
    b3 = tonumber(b1, 16) * (100 - by) / 100.0 + tonumber(b2, 16) * by / 100.0
    return "#" .. to_hex(r3) .. to_hex(g3) .. to_hex(b3)
end

local function center(text, ww)
    return string.rep(" ", math.floor((ww - #text) / 2)) .. text
end

function startup()
    local lines = multiline_string_to_table(text)
    local wheight = vim.api.nvim_win_get_height(0)
    local wwidth = vim.api.nvim_win_get_width(0)
    local sy = math.floor((wheight - #lines) / 2)
    local sx = math.floor((wwidth - #lines[1]) / 2)
    local output = {}

    for i = 1, sy do
        table.insert(output, "")
    end

    for i = 1, #lines do
        local line = center(lines[i], wwidth)
        table.insert(output, line)
    end

    for i = 1, sy do
        table.insert(output, "")
    end

    local version = vim.version()
    output[wheight - 5] = center(version.major .. "." .. version.minor .. "." .. version.patch, wwidth)
    output[wheight - 3] = center("'i could eat a knob at night'", wwidth)
    output[wheight - 2] = center("~  karl pilkington", wwidth)

    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(buf, 0, wheight, false, output)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "buflisted", false)
    vim.api.nvim_set_current_buf(buf)

    local ns = vim.api.nvim_create_namespace("")
    vim.api.nvim_set_hl_ns(ns)
    for i = 0, #lines do
        local hig = "splash." .. i
        vim.api.nvim_set_hl(ns, hig, { fg = blend_hex("#985d2a", "#3e2611", i / #lines * 100) })
        vim.api.nvim_buf_add_highlight(buf, ns, hig, sy + i, sx, sx + #lines[1])
    end
end

-- this file should be sourced on startup - no checks are performed here
startup()
