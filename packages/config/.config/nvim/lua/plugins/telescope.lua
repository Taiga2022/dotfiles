return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
        { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
      },
}
