hl.on("hyprland.start", function()
	local utils = require("utils")

	hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd(utils.uwsm("hyprpaper"))
	hl.exec_cmd(utils.uwsm("waybar"))
end)
