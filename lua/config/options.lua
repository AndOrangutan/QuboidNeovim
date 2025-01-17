-- Line numbers
vim.opt.number = true        -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers

-- Tab and indentation
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 4        -- Shift 4 spaces when tabbing
vim.opt.tabstop = 4           -- 1 tab = 4 spaces
vim.opt.smartindent = true    -- Auto-indent new lines

-- Search settings
vim.opt.ignorecase = true     -- Ignore case when searching
vim.opt.smartcase = true      -- Override ignorecase if search contains capitals
vim.opt.incsearch = true      -- Incremental search

-- Appearance
vim.opt.termguicolors = true  -- Enable true colors
vim.opt.signcolumn = "yes"    -- Always show sign column to prevent text shifting
vim.opt.wrap = false          -- Disable line wrapping

-- Mouse and clipboard
vim.opt.mouse = "a"           -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Undo and backup
vim.opt.undofile = true       -- Enable persistent undo
vim.opt.swapfile = false      -- Disable swapfile
vim.opt.backup = false        -- Disable backup

-- Performance
vim.opt.updatetime = 300      -- Faster completion
vim.opt.timeoutlen = 500      -- Time to wait for a mapped sequence to complete

-- Split windows
vim.opt.splitbelow = true     -- Split below by default
vim.opt.splitright = true     -- Split right by default

-- Disable mode display (modern status lines do this)
vim.opt.showmode = false
