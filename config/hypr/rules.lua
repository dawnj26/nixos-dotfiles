hl.window_rule({
	name = "Suppress Maximize",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "Volume Float",
	match = {
		class = "(org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)",
		title = "^(Volume Control|Pipewire Volume Control)$",
	},
	float = true,
})

hl.window_rule({
	name = "Float dialogs",
	match = {
		title = "^(Open File|Save File)$",
	},
	float = true,
})

hl.window_rule({
	name = "Float XDG dialogs",
	match = {
		class = "xdg-desktop-portal-gtk",
		title = "(.*)(wants to (open|save))",
	},
	float = true,
})
