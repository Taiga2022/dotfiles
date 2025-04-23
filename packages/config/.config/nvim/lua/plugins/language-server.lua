
return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
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
      automatic_installation = true,
    })
  end,
}

