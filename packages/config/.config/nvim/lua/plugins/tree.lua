---@diagnostic disable: undefined-global

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "TreeToggle" },
  },
  config = function()
    local api = require("nvim-tree.api")

    local function open_nvim_tree(data)
        -- buffer が [No Name] の場合
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        if no_name then
            -- ツリーを開く（フォーカスせず、ファイルを見つける）
            api.tree.open({ find_file = true })
        end
    end

    -- `VimEnter` 時に `open_nvim_tree` を実行
    vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })

    -- nvim-tree の設定
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
        adaptive_size = true,
      },
      renderer = {
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
    })
  end,
}

