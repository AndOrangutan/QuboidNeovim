
vim.keymap.set('n', 'Q', function()
    local write_ok, write = pcall(vim.api.nvim_command, 'write')
    if not write_ok then
        local confirm_val = vim.fn.confirm("Buffer couldn't write, CLOSE ANYWAY?", '&No\n&Yes')
        if 1 == confirm_val then
            return
        elseif 2 == confirm_val then
            vim.api.nvim_command('bdelete!')
        end
    else
        vim.api.nvim_command('bdelete')
    end
end, { desc = 'Save and Close Buffer' })


vim.keymap.set('n', '<leader>w+', '<c-w>+', { desc = '[w]indow height +' })
vim.keymap.set('n', '<leader>w-', '<c-w>+', { desc = '[w]indow height -' })
vim.keymap.set('n', '<leader>w<', '<c-w><', { desc = '[w]indow width <' })
vim.keymap.set('n', '<leader>w>', '<c-w>>', { desc = '[w]indow width >' })
vim.keymap.set('n', '<leader>w=', '<c-w>=', { desc = '[w]indow Equalize' })
vim.keymap.set('n', '<leader>w_', '<c-w>_', { desc = '[w]indow height max' })
vim.keymap.set('n', '<leader>w|', '<c-w>|', { desc = '[w]indow width max' })
vim.keymap.set('n', '<leader>wh', '<c-w>h', { desc = '[w]indow goto left' })
vim.keymap.set('n', '<leader>wj', '<c-w>j', { desc = '[w]indow goto down' })
vim.keymap.set('n', '<leader>wk', '<c-w>k', { desc = '[w]indow goto up' })
vim.keymap.set('n', '<leader>wl', '<c-w>l', { desc = '[w]indow goto right' })
vim.keymap.set('n', '<leader>wo', '<c-w>o', { desc = '[w]indow close [o]thers' })
vim.keymap.set('n', '<leader>wq', '<c-w>q', { desc = '[w]indow [q]uit' })
vim.keymap.set('n', '<leader>ws', '<c-w>s', { desc = '[w]indow [s]plit' })
vim.keymap.set('n', '<leader>wv', '<c-w>v', { desc = '[w]indow split [v]ert' })
vim.keymap.set('n', '<leader>wT', '<c-w>T', { desc = '[w]indow break into [T]ab' })
vim.keymap.set('n', '<leader>ww', '<c-w>w', { desc = '[w]indow s[w]itch' })
vim.keymap.set('n', '<leader>ww', '<c-w>x', { desc = '[w]indow swap next & current' })
