-- basics.lua - Heavily inspired by @tjdevries config

vim.g.loaded_matchparen = 1

local opt = vim.opt

-- Ignore compiled files @tjdevries
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"


-- State
--opt.showmode = false 
--opt.showcmd = false
opt.cmdheight = 1 -- Height of the command bar 

opt.showmatch = true -- Show matching brackets when text indicator is over them

opt.incsearch  = true -- Makes search act like search in modern browsers 
opt.ignorecase = true -- Igrnore case when searching...
opt.smartcase  = true -- ... unless there is a capital letter in the query
opt.hlsearch   = false  

opt.hidden = true -- I like having buffers stay around.

opt.relativenumber  = true -- Show line numbers
opt.number          = true -- But only the actual number for the line we're on

opt.equalalways = false -- I dont't like my windows changing all the time
opt.splitright  = true  --
opt.splitbelow  = true  --
opt.updatetime  = 1000 -- Make updates happen faster

opt.scrolloff    = 10 -- Make it so there are always ten lines below my cursor
--opt.smoothscroll = true


-- Cursorline highlighting control
-- Only have it on the active buffer
opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- TAB RELATED
opt.autoindent  = true 
opt.cindent     = true 
opt.wrap        = true

opt.tabstop     = 4
opt.shiftwidth  = 4
opt.softtabstop = 4
opt.expandtab   = true

opt.breakindent = true
opt.showbreak   = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak   = true

opt.foldmethod = "marker"
opt.foldlevel  = 0
opt.modelines  = 1

opt.belloff = "all" -- Just turn the dang bell off

-- opt.clipboard = 
opt.inccommand = "split"


-- STATUS LINE
-- FILES
opt.swapfile = false
opt.backup   = false
opt.undodir  = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.shada = { "!", "'1000", "<50", "s10", "h" }

-- TODO - Check this shit
-- Helpful related items:
--  1. :center, :left, :right
--  2. gw{motion} - Put cursor back after formatting motion.
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

vim.opt.signcolumn = "yes"
