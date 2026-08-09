return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "deep",
      transparent = false,

      highlights = {
        Normal = {
          bg = "#111318",
          fg = "#DCD7BA",
        },

        EndOfBuffer = {
          bg = "#111318",
          fg = "#111318",
        },

        Comment = {
          fg = "#727169",
          italic = true,
        },

        String = {
          fg = "#98BB6C",
        },

        Function = {
          fg = "#7E9CD8",
        },

        Keyword = {
          fg = "#957FB8",
        },

        Type = {
          fg = "#E6C384",
        },

        Constant = {
          fg = "#FFA066",
        },

        LineNr = {
          fg = "#54546D",
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
}
