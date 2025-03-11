-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true
config.window_background_opacity = 0.85
config.win32_system_backdrop = 'Acrylic'
config.window_decorations = "RESIZE"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'GruvboxDarkHard'

-- For example, changing the font:
wezterm.font("HackGen Console NF", {weight="Regular", stretch="Normal", style="Normal"})

-- Changing the default program: wsl
config.default_prog = { "wsl.exe", "--distribution", "ubuntu", "--cd", "~" }

-- keybinds
-- デフォルトのkeybindを無効化
config.disable_default_key_bindings = true
-- Leaderキーの設定
config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 4000 }
-- `keybinds.lua`を読み込み
local keybind = require 'keybinds'
-- keybindの設定
config.keys = keybind.keys
config.key_tables = keybind.key_tables


-- and finally, return the configuration to wezterm
return config
