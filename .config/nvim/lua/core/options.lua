--
-- Options config
--

-- Globals

local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

-- Options

local opt = vim.opt

-- only set clipboard if not in ssh, to make sure the OSC 52
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs

opt.fillchars = {
  diff = "╱",
  eob = " ",
}

opt.formatexpr = "v:lua.require'core.utils'.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.jumpoptions = "view"
opt.laststatus = 4 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.numberwidth = 8 -- Width of number column
opt.pumblend = 8 -- Popup blend
opt.pumheight = 8 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context

opt.sessionoptions = {
  "buffers", -- Hidden and unloaded buffers
  "curdir", -- The current directory
  "folds", -- Code folds
  "globals", -- Global variables
  "help", -- The help window
  "skiprtp", -- Exclude 'runtimepath' and 'packpath' from the options
  "tabpages", -- All tab pages
  "winsize", -- Window sizes
}

opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent

opt.shortmess:append({
  W = true,
  I = true,
  c = true,
  C = true,
})

opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = true

opt.spelllang = {
  "en",
  "pt_br",
}

opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.statuscolumn = [[%!v:lua.require'core.utils'.statuscolumn()]]
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
