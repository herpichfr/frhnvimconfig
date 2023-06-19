local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = false
opt.number = true

-- tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapptin
opt.wrap = false

-- search settings to smarthly search lower and upper case (taken from https://www.youtube.com/watch?v=vdn_pKJUda8)
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- make - look like as part of the word for neovim
opt.iskeyword:append("-")
