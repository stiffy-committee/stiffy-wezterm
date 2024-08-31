local M = {}

local wt = require("wezterm")
local utils = require("utils")


M.font = wt.font("JetBrains Mono")
M.color_scheme = "ayu"
-- M.window_background_image = utils.get_config_dir() .. "bg"
M.window_background_image_hsb = {
    brightness = 0.3
}
return M
