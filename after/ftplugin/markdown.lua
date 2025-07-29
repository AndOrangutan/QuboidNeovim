local spaces = 2
vim.opt_local.shiftwidth = spaces   -- Shift 4 spaces when tabbing
vim.opt_local.tabstop = spaces      -- 1 tab = 4 spaces

vim.opt_local.wrap = true
vim.opt_local.textwidth = 80


vim.keymap.set('n', 'j', 'gj', { desc = 'Wrap [j]ump Down', buffer = true })
vim.keymap.set('n', 'k', 'gk', { desc = 'Wrap [k]ick Up', buffer = true })
