return {
  'mason-org/mason.nvim',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
  },
  event = 'VeryLazy',
  config = function()
    local tools = {
      'prettierd',
      'stylua',
      'luacheck',
      'shellcheck',
      'shfmt',
      'lua-language-server',
    }

    require('mason').setup()

    local mr = require('mason-registry')
    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    require('mason-lspconfig').setup({
       ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "lua_ls",
        "sqlls",
        'pyright',
        'ts_ls',
        }
    })
  end,
}

