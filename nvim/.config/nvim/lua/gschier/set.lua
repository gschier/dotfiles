-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true

-- Set the terminal title
vim.opt.title = true
vim.opt.titlestring = '%{substitute(getcwd(), "^.*/", "", "")}%{empty(FugitiveHead())?"":("  ["..FugitiveHead().."]")}'

-- Indentation
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = false

-- Temporary files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. '/.vim/undodir'
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50

vim.g.mapleader = " "

-- For auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
