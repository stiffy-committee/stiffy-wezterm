local M = {}

local wt = require("wezterm")
local utils = require("utils")


M.font = wt.font("JetBrains Mono")
M.color_scheme = "ayu"
M.background = {
    {
        source = {
            Color = "#000000"
        },
        width = "100%",
        height = "100%",
        opacity = 0.90,

    },
    {
        source = {
            File = utils.get_config_dir() .. "bg",
        },
        hsb = {
            brightness = 0.3
        },
        repeat_x = "NoRepeat",
        repeat_y = "NoRepeat",
        vertical_align = "Middle",
        horizontal_align = "Center",
        height = "Contain",
        width = "Contain"

    },
}

return M
