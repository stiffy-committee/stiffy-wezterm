local wt = require("wezterm")
local cfg = wt.config_builder()
local utils = require("utils")

-- OS Specific setups
if utils.is_windows() then
    local windows = require("windows")
    cfg = utils.merge_tables(cfg, windows)
end

-- Keybinds
local keys = require("keys")
cfg = utils.merge_tables(cfg, keys)

-- Cosmetics
local cosmetic = require("cosmetic")
cfg = utils.merge_tables(cfg, cosmetic)

-- Debug
wt.on("update-right-status", function(window, pane)
    local leader = ""
    if window:leader_is_active() then
        leader = "LEADER"
    end
    window:set_right_status(leader)
end)

return cfg
