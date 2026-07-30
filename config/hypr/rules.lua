hl.window_rule({
	name = "Suppress Maximize",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "Volume Control",
	match = {
		class = "org\\.pulseaudio\\.pavucontrol|com\\.saivert\\.pwvucontrol",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.45)",
		"(monitor_h * 0.60)",
	},
})

hl.window_rule({
	name = "Bluetooth Manager",
	match = {
		class = "blueman-manager",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.50)",
		"(monitor_h * 0.65)",
	},
})

hl.window_rule({
	name = "Bluetooth Pairing",
	match = {
		class = "blueman-manager",
		title = ".*",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "Network Connections",
	match = {
		class = "nm-connection-editor|Nm-connection-editor",
		title = ".*Network Connections.*",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.45)",
		"(monitor_h * 0.60)",
	},
})

hl.window_rule({
	name = "Network Connection Editor",
	match = {
		class = "nm-connection-editor|Nm-connection-editor",
		title = "^Editing .+",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.60)",
		"(monitor_h * 0.80)",
	},
})

hl.window_rule({
	name = "Authentication",
	match = {
		class = "polkit-gnome-authentication-agent-1|polkit-kde-authentication-agent-1|lxqt-policykit-agent",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "XDG Portal",
	match = {
		class = "xdg-desktop-portal-gtk|xdg-desktop-portal-kde",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.55)",
		"(monitor_h * 0.70)",
	},
})

hl.window_rule({
	name = "File Dialogs",
	match = {
		title = ".*(Open|Save|Save As|Import|Export|Choose|Select|Browse|Folder|Directory).*",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.55)",
		"(monitor_h * 0.70)",
	},
})

hl.window_rule({
	name = "Zed Settings",
	match = {
		class = "dev\\.zed\\.Zed",
		title = ".*Settings.*",
	},
	float = true,
	center = true,
	size = {
		"(monitor_w * 0.65)",
		"(monitor_h * 0.80)",
	},
})

hl.window_rule({
	name = "Zed editor ERP Frontend",
	match = {
		initial_class = "dev.zed.Zed",
		initial_title = "erp-frontend",
	},
	workspace = "2 silent",
})

hl.window_rule({
	name = "Zed editor ERP Backend",
	match = {
		initial_class = "dev.zed.Zed",
		initial_title = "erp-backend",
	},
	workspace = "3 silent",
})

hl.window_rule({
	name = "Webstorm ERP Frontend",
	match = {
		class = "jetbrains-webstorm",
		title = "erp-frontend",
	},
	workspace = "2 silent",
})

hl.window_rule({
	name = "Webstorm ERP Backend",
	match = {
		class = "jetbrains-webstorm",
		title = "erp-backend",
	},
	workspace = "3 silent",
})
