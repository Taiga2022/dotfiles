return {
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      debounce_delay = 1000,
      condition = function(buf)
        return vim.bo[buf].buftype == ""
          and vim.bo[buf].modifiable
          and not vim.bo[buf].readonly
          and vim.api.nvim_buf_get_name(buf) ~= ""
      end,
    },
    config = function(_, opts)
      local autosave = require("auto-save")
      autosave.setup(opts)

      require("snacks.toggle").new({
        name = "Auto Save",
        get = autosave.enabled,
        set = function(enabled)
          if enabled then
            autosave.on()
          else
            autosave.off()
          end
        end,
      }):map("<leader>uv")
    end,
  },
}
