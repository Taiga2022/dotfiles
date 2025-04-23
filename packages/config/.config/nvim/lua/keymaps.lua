---@diagnostic disable: undefined-global
vim.keymap.set("i", "jk", "<Esc>")

-- -- bufferline close setting
-- vim.keymap.set('n', '<leader>wl', '<CMD>BufferLineCloseRight<CR>',{desc="BufferLineCloseRight"})
-- vim.keymap.set('n', '<leader>wh', '<CMD>BufferLineCloseLeft<CR>',{desc="BufferLineCloseLeft"})
-- vim.keymap.set('n', '<leader>wall', '<CMD>BufferLineCloseOthers<CR>',{desc="BufferLineCloseOthers"})
-- vim.keymap.set('n', '<leader>we', '<CMD>BufferLinePickClose<CR>',{desc="BufferLinePickClose"})
-- 
-- -- (reference)https://github.com/kazhala/dotfiles/blob/master/.config/nvim/lua/kaz/plugins/bufferline.lua
-- vim.keymap.set('n', 'gb', '<CMD>BufferLinePick<CR>',{desc="BufferLinePick"})
-- vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>',{desc="BufferLinePickClose"})
vim.keymap.set('n', '<C-l>', '<CMD>BufferLineCycleNext<CR>',{desc="BufferLineCycleNext"})
vim.keymap.set('n', '<C-h>', '<CMD>BufferLineCyclePrev<CR>',{desc="BufferLineCyclePrev"})
-- vim.keymap.set('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>',{desc="BufferLineSortByDirectory"})
