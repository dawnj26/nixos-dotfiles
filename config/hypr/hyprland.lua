require("autostart")
require("keybinds")
require("monitors")
require("rules")
require("input")
require("appearance")
require("workspace")



-- For Noctalia Color templates
require("noctalia").apply_theme()

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do
    local path = "/home/dawn/nixos-dotfiles/config/hypr/monitors.lua"; local file = io.open(path, "r"); if file then
        file:close(); dofile(path)
    end
end
