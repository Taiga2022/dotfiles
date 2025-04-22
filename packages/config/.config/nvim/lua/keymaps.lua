---@diagnostic disable: undefined-global
vim.keymap.set("i", "jk", "<Esc>")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>o', vim.diagnostic.open_float, { desc = "open_error_message" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, { desc = 'format Text' }, opts)
    end,
})

-- use keymap in file-header-view(bufferline-plugin)
-- bufferline close setting
vim.keymap.set('n', '<leader>wl', '<CMD>BufferLineCloseRight<CR>',{desc="BufferLineCloseRight"})
vim.keymap.set('n', '<leader>wh', '<CMD>BufferLineCloseLeft<CR>',{desc="BufferLineCloseLeft"})
vim.keymap.set('n', '<leader>wall', '<CMD>BufferLineCloseOthers<CR>',{desc="BufferLineCloseOthers"})
vim.keymap.set('n', '<leader>we', '<CMD>BufferLinePickClose<CR>',{desc="BufferLinePickClose"})

-- (reference)https://github.com/kazhala/dotfiles/blob/master/.config/nvim/lua/kaz/plugins/bufferline.lua
vim.keymap.set('n', 'gb', '<CMD>BufferLinePick<CR>',{desc="BufferLinePick"})
vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>',{desc="BufferLinePickClose"})
vim.keymap.set('n', '<C-l>', '<CMD>BufferLineCycleNext<CR>',{desc="BufferLineCycleNext"})
vim.keymap.set('n', '<C-h>', '<CMD>BufferLineCyclePrev<CR>',{desc="BufferLineCyclePrev"})
vim.keymap.set('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>',{desc="BufferLineSortByDirectory"})
