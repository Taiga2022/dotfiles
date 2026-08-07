local wezterm = require("wezterm")
local act = wezterm.action

return {
  keys = {
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    { key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 3 }) },
    { key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 3 }) },
    { key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 3 }) },
    { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 3 }) },

    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    { key = "v", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
  },

  key_tables = {
    copy_mode = wezterm.gui.default_key_tables().copy_mode,
    search_mode = wezterm.gui.default_key_tables().search_mode,
  },
}
