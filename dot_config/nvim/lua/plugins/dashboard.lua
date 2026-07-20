return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard.preset.header = [[
                                                                   
      ████ ██████           █████      ██                 
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]

      opts.dashboard.sections = {
        { section = "header" },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        {
          icon = " ",
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      }
      opts.dashboard.preset.keys = {
        {
          icon = " ",
          key = "f",
          desc = "Find File",
          action = ":lua Snacks.dashboard.pick('files')",
        },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        {
          icon = " ",
          key = "g",
          desc = "Find Text",
          action = ":lua Snacks.dashboard.pick('live_grep')",
        },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
        },
        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
        {
          icon = "󰒲 ",
          key = "l",
          desc = "Lazy",
          action = ":Lazy",
        },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        {
          icon = " ",
          key = "q",
          desc = "Quit",
          action = ":qa",
        },
      }
    end,
  },
}
