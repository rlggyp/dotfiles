local wezterm = require('wezterm')

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    return ' ' .. tostring(tab.tab_index + 1) .. ' '
  end
)

config = wezterm.config_builder()

config = {
	term = 'xterm',
	color_scheme = 'tokyonight',
	automatically_reload_config = false,

	enable_tab_bar = true,
	use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

	initial_cols = 150,
	initial_rows = 35,

	disable_default_key_bindings = true,

	window_close_confirmation = 'NeverPrompt',
	window_decorations = 'RESIZE',

	font = wezterm.font('JetbrainsMono NF', {weight = 'Bold'}),
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	font_size = 10,

	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},

	keys = {
		{ key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
		{ key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(1) },
		{ key = '1', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(0) },
		{ key = '2', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(1) },
		{ key = '3', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(2) },
		{ key = '4', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(3) },
		{ key = '5', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(4) },
		{ key = '6', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(5) },
		{ key = '7', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(6) },
		{ key = '8', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(7) },
		{ key = '9', mods = 'ALT|CTRL', action = wezterm.action.ActivateTab(8) },
		{ key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab {confirm=true} },
		{ key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
		{ key = 'r', mods = 'ALT|SHIFT', action = wezterm.action.ReloadConfiguration },
		{ key = 'f', mods = 'ALT|SHIFT', action = wezterm.action.ToggleFullScreen },
		{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
		{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
		{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
		{ key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
		{ key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
		-- { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical {domain='CurrentPaneDomain'} },
		-- { key = '|', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal {domain='CurrentPaneDomain'} },
	},
}

return config
