local M = {}

local wt = require("wezterm")
local utils = require("utils")
local const = require("constants")
local color_scheme = "Equilibrium Gray Dark (base16)"

M.font = wt.font_with_fallback{
    "Iosevka Curly",
    "ProggyClean CE Nerd Font",
    "JetBrains Mono"
}

M.color_scheme_dirs = { 'colors' }
-- M.color_scheme = "stiff"
M.color_scheme = color_scheme

local cur_bg_index = 1
local backgrounds = {
    {
        {
            source = {
                Color = wt.color.get_builtin_schemes()[color_scheme].background
            },
            width = "100%",
            height = "100%",
            opacity = 0.90,

        },
        {
            source = {
                File = utils.get_config_dir() .. "bg.png",
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
    },
    {
        source = {
            Color = wt.color.get_builtin_schemes()[color_scheme].background
        },
        width = "100%",
        height = "100%",
        opacity = 0.90,

    },
    {
        source = {
            Color = "#0a0a0a"
        },
        width = "100%",
        height = "100%",
    }
}

M.background = backgrounds[1]

local function get_bg(window, cycle)
    local overrides = window:get_config_overrides() or {}

    if cycle then
        cur_bg_index = cur_bg_index + 1
    end

    overrides.background = {
        backgrounds[((cur_bg_index - 1) % #backgrounds) + 1]

    }
    wt.log_info(cur_bg_index)
    wt.log_info(backgrounds[((cur_bg_index - 1) % #backgrounds) + 1])

    window:set_config_overrides(overrides)
end

wt.on(const.SWITCH_BACKGROUND, function(window, pane)
    get_bg(window, true)
end)

return M
