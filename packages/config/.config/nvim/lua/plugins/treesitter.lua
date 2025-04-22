return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
          "lua",
          "vim",
          "markdown",
          "cpp",
          "c",
      },
      auto_install=true,
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
