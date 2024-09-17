local M = {}

local wt = require("wezterm")
local utils = require("utils")
local const = require("constants")

local default_bg = {
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

M.font = wt.font("JetBrains Mono")
M.color_scheme = "ayu"
M.background = default_bg

local bg_state = 1
wt.on(const.SWITCH_BACKGROUND, function(window, pane)
    local overrides = window:get_config_overrides() or {}

    if bg_state == 1 then
        overrides.background = {
            {
                source = {
                    Color = "#0a0a0a"
                },
                width = "100%",
                height = "100%",
            }
        }
        bg_state = bg_state + 1
    else
        overrides.background = default_bg
        bg_state = 1
    end
    window:set_config_overrides(overrides)
end)

return M
