return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false, -- または event = "VeryLazy" に変更可能
  config = function()
    if vim.g.started_by_firenvim then
      return
    end

    local bufferline = require('bufferline')

    bufferline.setup({
      options = {
        mode = 'buffers',
        numbers = 'ordinal',
        hover = {
          enabled = false,
          delay = 200,
          reveal = { 'close' },
        },
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        name_formatter = function(buf)
          if buf.name:match('%.md') then
            return vim.fn.fnamemodify(buf.name, ':t:r')
          end
        end,
        max_name_length = 18,
        max_prefix_length = 18,
        tab_size = 17,
        truncate_names = true,
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', padding = 1 },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'slant',
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = '  ' .. error, fg = '#EC5241' })
            end
            if warning ~= 0 then
              table.insert(result, { text = '  ' .. warning, fg = '#EFB839' })
            end
            if hint ~= 0 then
              table.insert(result, { text = '  ' .. hint, fg = '#A3BA5E' })
            end
            if info ~= 0 then
              table.insert(result, { text = '  ' .. info, fg = '#7EA9A7' })
            end
            return result
          end,
        },
      },
    })

    -- キーマップもここで設定しておくといい感じ
    vim.keymap.set('n', '<C-l>', '<CMD>BufferLineCycleNext<CR>', { desc = 'BufferLineCycleNext' })
    vim.keymap.set('n', '<C-h>', '<CMD>BufferLineCyclePrev<CR>', { desc = 'BufferLineCyclePrev' })
  end,
}

