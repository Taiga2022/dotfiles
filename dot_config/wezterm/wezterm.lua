-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "HackGen Console NF",
})
config.font_size = 14.0
config.use_ime = true
config.window_background_opacity = 0.94
config.win32_system_backdrop = "Acrylic"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 10,
  right = 10,
  top = 6,
  bottom = 6,
}
config.use_fancy_tab_bar = false
config.tab_max_width = 24
config.hide_tab_bar_if_only_one_tab = false
config.scrollback_lines = 20000

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

-- Keep platform-native defaults and use a leader for pane operations.
config.leader = { key = "g", mods = "CTRL", timeout_milliseconds = 4000 }
local keybind = require("keybinds")
config.keys = keybind.keys
config.key_tables = keybind.key_tables

wezterm.on("update-right-status", function(window)
  if window:leader_is_active() then
    window:set_right_status(wezterm.format({
      { Background = { Color = "#E6C384" } },
      { Foreground = { Color = "#111318" } },
      { Attribute = { Intensity = "Bold" } },
      { Text = "  LEADER  " },
    }))
  else
    window:set_right_status("")
  end
end)

local function basename(path)
  return path and path:gsub("(.*[/\\])(.*)", "%2") or ""
end

wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  if cwd then
    cwd = cwd.file_path or tostring(cwd):gsub("^file://[^/]*", "")
  end

  local directory = basename(cwd)
  local process = basename(pane.foreground_process_name)
  local title = directory
  if process ~= "" then
    title = title .. " · " .. process
  end

  return "  " .. title .. "  "
end)

-- and finally, return the configuration to wezterm
return config
