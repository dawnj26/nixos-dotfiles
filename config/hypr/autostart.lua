hl.on("hyprland.start", function()
	local utils = require("utils")

	hl.exec_cmd(utils.uwsm("hyprpaper"))
	hl.exec_cmd(utils.uwsm("mako"))
	hl.exec_cmd(utils.uwsm("waybar"))
end)
