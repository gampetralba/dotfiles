-- Leader
vim.g.mapleader = ","

-- Emmet leader key (must be set before plugin loads)
vim.g.user_emmet_leader_key = '<C-Z>'

-- Visual wrapping
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Mouse
vim.opt.mouse = "a"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Buffer
vim.opt.hidden = true

-- String encoding
vim.opt.encoding = "utf-8"

-- Disable search highlight
vim.opt.hlsearch = false -- Disable search highlighting

-- Change cursor between modes (only needed for terminal Neovim)
vim.opt.guicursor = {
    "n-v-c:block", -- Normal, Visual, Command mode: Block cursor
    "i-ci:ver25", -- Insert and Command-line Insert mode: Vertical cursor (25% width)
    "r:hor20" -- Replace mode: Horizontal cursor (20% height)
}

-- Don't wrap text when typing
vim.opt.formatoptions:remove("t")

-- Allow backspace for indents, end-of-line, and start of insert
vim.opt.backspace = {"indent", "eol", "start"}

-- Enable true color support
vim.opt.termguicolors = true

-- Enable global statusline (Neovim 0.7+)
vim.opt.laststatus = 3

-- Set winbar
vim.opt.winbar = "%=%m %f"
