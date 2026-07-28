require("autostart")
require("keybinds")

local ok, _ = pcall(require, "monitors")

require("rules")
require("input")
require("appearance")

if not ok then
	hl.dispatch(hl.dsp.exec_cmd('nofify-send "Warning" "monitors.lua is missing."'))
end
