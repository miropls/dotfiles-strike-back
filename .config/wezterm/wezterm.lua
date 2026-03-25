local wezterm = require("wezterm")
local config = wezterm.config_builder()
local keys = require("keys")

-- =============================================================================
-- Platform: Windows — default to Fedora 43 in WSL
-- =============================================================================
if wezterm.target_triple:find("windows") then
	config.default_domain = "WSL:Fedora-43"
end

-- =============================================================================
-- Theme
-- =============================================================================
-- Color scheme defined in colors/kanagawa-dragon.toml (TOML format required
-- for separate files; the colors/ subdirectory is searched automatically).
config.color_scheme = "kanagawa-dragon"

-- =============================================================================
-- Window / Appearance
-- =============================================================================
config.window_background_opacity = 0.9

-- Hides the title bar and macOS traffic light buttons entirely.
-- Ghostty: window-decoration = true, macos-window-buttons = hidden,
--          macos-titlebar-style = transparent
-- Note: there is no WezTerm equivalent for window-theme = ghostty
config.window_decorations = "RESIZE"

config.hide_mouse_cursor_when_typing = true

-- tab-inherit-working-directory and split-inherit-working-directory are the
-- default WezTerm behavior — no config needed.

-- desktop-notifications: no WezTerm equivalent for terminal bell → OS notification.
-- auto-update / auto-update-channel: no WezTerm equivalent.

-- =============================================================================
-- Font
-- =============================================================================
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 18
-- font-thicken: omitted (no direct WezTerm equivalent; CoreText renders well)

-- =============================================================================
-- Clipboard / Input
-- =============================================================================
-- macos-option-as-alt = left
-- Treat the left Option key as Alt, right Option composes characters.
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- =============================================================================
-- Tab Bar (Fancy / macOS-native style)
-- =============================================================================
-- window_frame controls the title bar area around the tab pills.
config.window_frame = {
	font = wezterm.font("JetBrainsMono Nerd Font Mono"),
	font_size = 13,
	active_titlebar_bg = "#1d1b19",
	inactive_titlebar_bg = "#1d1b19",
}

-- colors.tab_bar controls the tab pill colors themselves.
config.colors = {
	tab_bar = {
		-- The strip of space behind the tab pills.
		background = "#1d1b19",
		-- Active (focused) tab pill: blend into the terminal background.
		active_tab = {
			bg_color = "#181616",
			fg_color = "#c5c9c5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		-- Inactive tab pills.
		inactive_tab = {
			bg_color = "#1d1b19",
			fg_color = "#72726f",
		},
		inactive_tab_hover = {
			bg_color = "#242220",
			fg_color = "#c5c9c5",
			italic = false,
		},
		-- The "+" new-tab button.
		new_tab = {
			bg_color = "#1d1b19",
			fg_color = "#72726f",
		},
		new_tab_hover = {
			bg_color = "#242220",
			fg_color = "#c5c9c5",
			italic = false,
		},
	},
}

-- =============================================================================
-- Keybinds
-- =============================================================================
-- Default key bindings are kept; our custom keys extend/override them.
config.keys = keys.keys
config.mouse_bindings = keys.mouse_bindings

return config
