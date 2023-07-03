-- IMPORTANT:
-- this file is a modified version of
-- https://github.com/nekonako/xresources-nvim
-- including changes from
-- https://github.com/lnhrnndz/xresources-nvim
-- credit goes to the original authors
-- this file is licensed in line with the original copies - ie. GNU GPLv2

local function get_xresources_color (c)
   local command = io.popen('xrdb -query | grep ' .. c .. ' -m 1 | cut -f 2')
   local color = command:read("*l")
   return color
end

local function get_lighter_color(c, hex)
   local before_color = get_xresources_color(c)
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) + hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

local function get_darker_color(c, hex)
   local before_color = get_xresources_color(c)
   local t = tostring(before_color)
   local s = string.sub(t, 2, 7)
   local after_color = tonumber('0x' .. s) - hex
   local final_color = "#" .. string.format("%x", after_color)
   return final_color
end

local xresources = {
   fg = get_xresources_color('foreground');
   bg = get_xresources_color('background');
   black = get_xresources_color('color0');
   red = get_xresources_color('color1');
   green = get_xresources_color('color2');
   yellow =get_xresources_color('color3');
   blue = get_xresources_color('color4');
   purple = get_xresources_color('color5'),
   cyan = get_xresources_color('color6');
   white = get_xresources_color('color7');
   light_black = get_xresources_color('color8');
   light_red = get_xresources_color('color9');
   light_green = get_xresources_color('color10');
   light_yellow = get_xresources_color('color11');
   light_blue = get_xresources_color('color12');
   light_purple = get_xresources_color('color13');
   light_cyan = get_xresources_color('color14');
   light_white = get_xresources_color('color15');
   grey = vim.o.background == 'light' and get_darker_color('background', 0xf0f10) or get_lighter_color('background', 0xf0f10);
   grey1 = vim.o.background == 'light' and get_darker_color('background', 0x363940) or get_lighter_color('background', 0x363940);
   none = 'NONE';
}

function xresources.terminal_color()
   vim.g.terminal_color_0 = xresources.bg
   vim.g.terminal_color_1 = xresources.red
   vim.g.terminal_color_2 = xresources.green
   vim.g.terminal_color_3 = xresources.yellow
   vim.g.terminal_color_4 = xresources.blue
   vim.g.terminal_color_5 = xresources.purple
   vim.g.terminal_color_6 = xresources.cyan
   vim.g.terminal_color_7 = xresources.fg
   vim.g.terminal_color_8 = xresources.bg
   vim.g.terminal_color_9 = xresources.red
   vim.g.terminal_color_10 = xresources.green
   vim.g.terminal_color_11 = xresources.yellow
   vim.g.terminal_color_12 = xresources.blue
   vim.g.terminal_color_13 = xresources.purple
   vim.g.terminal_color_14 = xresources.cyan
   vim.g.terminal_color_15 = xresources.fg
end

-- ====================
-- Highlight function
-- ====================
function xresources.highlight(group, color)
   local style = color.style and 'gui=' .. color.style or 'gui=NONE'
   local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
   local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
   local sp = color.sp and 'guisp=' .. color.sp or ''
   vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg ..
      ' ' .. bg..' '..sp)
end

function load_syntax()
   local syntax = {

      -- syntax group
      Boolean = {fg=xresources.yellow};
      Comment = {fg=xresources.grey1};
      Constant = {fg=xresources.red};
      Character = {fg=xresources.green};
      Conditional = {fg=xresources.purple};
      Debug = {};
      Define = {fg=xresources.purple};
      Delimiter = {};
      Error = {fg=xresources.red};
      Exception = {fg=xresources.purple};
      Float = {fg=xresources.yellow};
      Function = {fg=xresources.blue};
      Identifier = {fg=xresources.fg};
      Ignore = {};
      Include = {fg=xresources.blue};
      Keyword = {fg=xresources.red};
      Label = {fg=xresources.purple};
      Macro = {fg=xresources.purple};
      Number = {fg=xresources.yellow};
      Operator = {fg=xresources.purple};
      PreProc = {fg=xresources.yellow};
      PreCondit = {fg=xresources.yellow};
      Repeat = {fg=xresources.purple};
      Statement = {fg=xresources.purple};
      StorageClass = {fg=xresources.yellow};
      Special = {fg=xresources.blue};
      SpecialChar = {fg=xresources.yellow};
      Structure = {fg=xresources.yellow};
      String = {fg=xresources.green};
      SpecialComment = {fg=xresources.grey1};
      Typedef = {fg=xresources.yellow};
      Tag = {};
      Type = {fg=xresources.yellow};
      Todo = {fg=xresources.purple};
      Underlined = {fg=xresources.none,style='underline'};

      -- treesitter
      TSError = { fg = xresources.red };
      TSPunctDelimitter = { fg = xresources.cyan };
      TSPunctBracket = {};
      TSPunctSpecial = { fg = xresources.cyan };
      TSConstant = { fg = xresources.yellow };
      TSConstBuiltin = { fg = xresources.blue };
      TSContMacro = { fg = xresources.purple };
      TSString = { fg = xresources.green };
      TSStringRegex = { fg = xresources.red };
      TSCharacter = { fg = xresources.green };
      TSNumber = { fg = xresources.yellow };
      TSBoolean = { fg = xresources.yellow };
      TSFloat = { fg = xresources.yellow };
      TSAnnotation = { fg = xresources.blue };
      TSAttribute = { fg = xresources.yellow };
      TSNamespace = { fg = xresources.blue };
      TSFunctionBuiltin = { fg = xresources.blue };
      TSFunction = { fg = xresources.blue };
      TSFuncMacro = { fg = xresources.blue };
      TSParameter = { fg = xresources.red };
      TSParameterReference = { fg = xresources.red };
      TSMethod = { fg = xresources.blue };
      TSField = { fg = xresources.yellow };
      TSProperty = { fg = xresources.red };
      TSConstructor = { fg = xresources.blue };
      TSConditional= { fg = xresources.purple };
      TSRepeat= { fg = xresources.purple };
      TSLabel= { fg = xresources.purple };
      TSKeyword= { fg = xresources.purple };
      TSKeywordFunction= { fg = xresources.purple };
      TSKeywordOperator= { fg = xresources.cyan };
      TSOperator= { fg = xresources.cyan };
      TSExeption= { fg = xresources.red };
      TSType= { fg = xresources.blue };
      TSTypeBuiltin= { fg = xresources.red };
      TSStructure= { fg = xresources.yellow };
      TSInclude= { fg = xresources.red };
      TSVariable= {fg= xresources.yellow};
      TSVariableBuiltin= { fg = xresources.blue };
      TSText= {};
      TSStrong= { fg = xresources.purple };
      TSEmphasis= { fg = xresources.cyan };
      TSUnderline= { fg = xresources.yellow };
      TSTitle= { fg = xresources.yellow };
      TSLiteral= { fg = xresources.green };
      TSUri= { fg = xresources.green };
      TSTag= {};
      TSTagDelimitter= {};

      -- highlight group
      BufferInactive= { fg=xresources.fg,bg=xresources.grey };
      BufferInactiveTarge = { fg=xresources.fg, bg=xresources.grey };
      BufferInactiveSign = { fg=xresources.blue, bg=xresources.grey };
      BufferCurrent = { fg=xresources.yellow, bg=xresources.bg, style ='bold'};
      BufferCurrentSign = { fg=xresources.blue, bg=xresources.bg };
      BufferTabPageFill = { fg=xresources.blue, bg=xresources.bg };
      BufferCurrentMod = { fg=xresources.blue, bg=xresources.bg };
      BufferInactiveMod = { fg=xresources.blue, bg=xresources.grey };
      ColorColumn = {fg=xresources.fg,bg=xresources.grey};
      Conceal = {fg=xresources.grey,bg=xresources.none};
      CursorLineNr = {fg=xresources.blue};
      CursorIM = {fg=xresources.none,bg=xresources.none,style='reverse'};
      CursorColumn = {fg=xresources.none,bg=xresources.grey};
      CursorLine = {fg=xresources.none,bg=xresources.grey};
      Cursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      DiffAdd = {fg=xresources.bg,bg=xresources.green};
      DiffChange = {fg=xresources.bg,bg=xresources.yellow};
      DiffDelete = {fg=xresources.bg,bg=xresources.red};
      DiffText = {fg=xresources.bg,bg=xresources.fg};
      Directory = {fg=xresources.blue,bg=xresources.none};
      debugBreakpoint = {fg=xresources.bg,bg=xresources.red};
      EndOfBuffer = {fg=xresources.bg,bg=xresources.none};
      ErrorMsg = {fg=xresources.red,bg=xresources.none,style='bold'};
      FoldColumn = {fg=xresources.fg,bg=xresources.bg};
      Folded = {fg=xresources.grey1,bg=xresources.grey};
      iCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      IncSearch = {fg=xresources.grey1,bg=xresources.yellow,style=xresources.none};
      lCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      LineNr = {fg=xresources.grey1};
      ModeMsg = {fg=xresources.fg,bg=xresources.none,style='bold'};
      MatchParen = {fg=xresources.red,bg=xresources.none};
      Normal = {fg = xresources.fg,bg=xresources.bg};
      NormalFloat = {fg=xresources.fg,bg=xresources.grey};
      NonText = {fg=xresources.grey};
      Pmenu = {fg=xresources.fg,bg=xresources.grey};
      PmenuSel = {fg=xresources.grey,bg=xresources.blue};
      PmenuSelBold = {fg=xresources.grey1,g=xresources.blue};
      PmenuSbar = {fg=xresources.none,bg=xresources.grey};
      PmenuThumb = {fg=xresources.purple,bg=xresources.green};
      Question = {fg=xresources.yellow};
      QuickFixLine = {fg=xresources.purple,style='bold'};
      StatusLine = {fg=xresources.fg,bg=xresources.grey,style=xresources.none};
      StatusLineNC = {fg=xresources.fg,bg=xresources.grey,style=xresources.none};
      SpellBad = {fg=xresources.red,bg=xresources.none,style='undercurl'};
      SpellCap = {fg=xresources.blue,bg=xresources.none,style='undercurl'};
      SpellLocal = {fg=xresources.cyan,bg=xresources.none,style='undercurl'};
      SpellRare = {fg=xresources.purple,bg=xresources.none,style = 'undercurl'};
      SignColumn = {fg=xresources.fg,bg=xresources.bg};
      Search = {fg=xresources.bg,bg=xresources.yellow};
      SpecialKey = {fg=xresources.grey1};
      TabLineSel = {bg=xresources.bg};
      Title = {fg=xresources.green,style='bold'};
      Terminal = {fg = xresources.fg,bg=xresources.bg};
      TabLineFill = {style=xresources.none};
      VertSplit = {fg=xresources.grey,bg=xresources.bg};
      vCursor = {fg=xresources.none,bg=xresources.none,style='reverse'};
      WarningMsg = {fg=xresources.yellow,bg=xresources.none,style='bold'};
      Whitespace = {fg=xresources.grey1};
      WildMenu = {fg=xresources.fg,bg=xresources.green};
      Visual = {fg=xresources.none,bg=xresources.grey};
      VisualNOS = {fg=xresources.bg,bg=xresources.fg};
   }
   return syntax
end

function load_plugin_syntax()
    local syntax = {
        TelescopeBorder = {fg=xresources.cyan};
        TelescopePromptBorder = {fg=xresources.blue}
    }
    return syntax
end

local async_load_plugin 
async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function ()
   xresources.terminal_color()
   local syntax = load_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end

   local pluin_syntax = load_plugin_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end

   async_load_plugin:close()
end))

function xresources.colorscheme()
   vim.api.nvim_command('hi clear')
   if vim.fn.exists('syntax_on') then
      vim.api.nvim_command('syntax reset')
   end
   vim.o.termguicolors = true
   vim.g.colors_name = 'xresources'

   local syntax = load_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end

   local pluin_syntax = load_plugin_syntax()
   for group,colors in pairs(syntax) do
      xresources.highlight(group,colors)
   end

   async_load_plugin:send()
end

xresources.colorscheme()
