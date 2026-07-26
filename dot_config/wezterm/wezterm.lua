-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true
config.window_background_opacity = 0.85
config.win32_system_backdrop = "Acrylic"
config.window_decorations = "RESIZE"

-- Match the Neovim palette. Gruvbox character comes from the warm accents and
-- Nerd Font icons used by the prompt rather than a separate terminal palette.
config.colors = {
  foreground = "#DCD7BA",
  background = "#111318",
  cursor_bg = "#DCD7BA",
  cursor_fg = "#111318",
  cursor_border = "#DCD7BA",
  selection_fg = "#DCD7BA",
  selection_bg = "#2D4F67",
  scrollbar_thumb = "#54546D",
  split = "#54546D",
  ansi = {
    "#111318", "#E46876", "#98BB6C", "#E6C384",
    "#7E9CD8", "#957FB8", "#7FB4CA", "#DCD7BA",
  },
  brights = {
    "#727169", "#E46876", "#98BB6C", "#E6C384",
    "#7E9CD8", "#957FB8", "#7FB4CA", "#FFFFFF",
  },
  tab_bar = {
    background = "#111318",
    active_tab = { bg_color = "#E6C384", fg_color = "#111318", intensity = "Bold" },
    inactive_tab = { bg_color = "#1F2335", fg_color = "#727169" },
    inactive_tab_hover = { bg_color = "#2A2E42", fg_color = "#DCD7BA" },
    new_tab = { bg_color = "#111318", fg_color = "#727169" },
    new_tab_hover = { bg_color = "#1F2335", fg_color = "#E6C384" },
  },
}

-- keybinds
-- デフォルトのkeybindを無効化
config.disable_default_key_bindings = true
-- Leaderキーの設定
config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 4000 }
-- `keybinds.lua`を読み込み
local keybind = require("keybinds")
-- keybindの設定
config.keys = keybind.keys
config.key_tables = keybind.key_tables

-- and finally, return the configuration to wezterm
return config
