local wt = require("wezterm")
local cfg = wt.config_builder()
local utils = require("utils")

cfg.prefer_to_spawn_tabs = true
cfg.window_close_confirmation = "NeverPrompt"

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

--  \~~- ~_
--   ,---( /\
--   / #~~ _ >>>
--  /  \ /
--
--
--  Stiffy
