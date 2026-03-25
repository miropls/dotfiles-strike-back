local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.keys = {
  -- Config
  { mods = "ALT|CTRL",   key = "y",          action = act.ReloadConfiguration },

  -- Clipboard
  { mods = "ALT",        key = "c",          action = act.CopyTo("Clipboard") },
  { mods = "ALT",        key = "v",          action = act.PasteFrom("Clipboard") },

  -- Font size
  { mods = "ALT",        key = "+",          action = act.IncreaseFontSize },
  { mods = "ALT",        key = "-",          action = act.DecreaseFontSize },
  { mods = "ALT",        key = "0",          action = act.ResetFontSize },

  -- Windows / Tabs
  { mods = "SUPER",      key = "n",          action = act.SpawnWindow },
  { mods = "SUPER",      key = "t",          action = act.SpawnTab("CurrentPaneDomain") },
  { mods = "SUPER",      key = "w",          action = act.CloseCurrentTab({ confirm = false }) },
  { mods = "CTRL|SHIFT", key = "w",          action = act.CloseCurrentTab({ confirm = false }) },

  -- Tab navigation
  { mods = "CTRL|SHIFT", key = "LeftArrow",  action = act.ActivateTabRelative(-1) },
  { mods = "CTRL|SHIFT", key = "RightArrow", action = act.ActivateTabRelative(1) },
  { mods = "SUPER",      key = "LeftArrow",  action = act.ActivateTabRelative(-1) },
  { mods = "SUPER",      key = "RightArrow", action = act.ActivateTabRelative(1) },

  -- Suppress alt+left / alt+right (alt+left=unbind, alt+right=unbind in Ghostty)
  { mods = "ALT",        key = "LeftArrow",  action = act.DisableDefaultAssignment },
  { mods = "ALT",        key = "RightArrow", action = act.DisableDefaultAssignment },

  -- Splits: create
  { mods = "SUPER|ALT",  key = "v",          action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { mods = "SUPER|ALT",  key = "s",          action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { mods = "SUPER|ALT",  key = "w",          action = act.CloseCurrentPane({ confirm = false }) },

  -- Splits: focus (hjkl)
  { mods = "SUPER|ALT",  key = "h",          action = act.ActivatePaneDirection("Left") },
  { mods = "SUPER|ALT",  key = "j",          action = act.ActivatePaneDirection("Down") },
  { mods = "SUPER|ALT",  key = "k",          action = act.ActivatePaneDirection("Up") },
  { mods = "SUPER|ALT",  key = "l",          action = act.ActivatePaneDirection("Right") },

  -- Splits: focus (Colemak-DH mnei)
  { mods = "SUPER|ALT",  key = "m",          action = act.ActivatePaneDirection("Left") },
  { mods = "SUPER|ALT",  key = "n",          action = act.ActivatePaneDirection("Down") },
  { mods = "SUPER|ALT",  key = "e",          action = act.ActivatePaneDirection("Up") },
  { mods = "SUPER|ALT",  key = "i",          action = act.ActivatePaneDirection("Right") },

  -- Splits: focus (arrow keys)
  { mods = "SUPER|ALT",  key = "LeftArrow",  action = act.ActivatePaneDirection("Left") },
  { mods = "SUPER|ALT",  key = "DownArrow",  action = act.ActivatePaneDirection("Down") },
  { mods = "SUPER|ALT",  key = "UpArrow",    action = act.ActivatePaneDirection("Up") },
  { mods = "SUPER|ALT",  key = "RightArrow", action = act.ActivatePaneDirection("Right") },
}

-- copy-on-select = clipboard
-- WezTerm handles this via mouse bindings: on mouse-up after selection,
-- copy directly to the system clipboard instead of the primary selection.
M.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
  },
}

return M
