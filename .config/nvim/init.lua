---@diagnostic disable: undefined-global
require("config.lazy")
require("base")
require("keymaps")

local function open_nvim_tree(data)
    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if no_name then
        -- open the tree, find the file but don't focus it
        require("nvim-tree.api").tree.toggle({ focus = true, find_file = true, })
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


