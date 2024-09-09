local wt = require("wezterm")
local M = {}

local clipboard_location = "Clipboard"

M.leader = {
    key = "w",
    mods = "ALT",
    timeout_milliseconds = 1000,
}

M.keys = {
    -- PANE NAVIGATION
    {
        key = "v",
        mods = "LEADER",
        action = wt.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
        key = "h",
        mods = "LEADER",
        action = wt.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
        key = "c",
        mods = "LEADER",
        action = wt.action.CloseCurrentPane { confirm = true },
    },
    {
        key = "h",
        mods = "LEADER|ALT",
        action = wt.action.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "LEADER|ALT",
        action = wt.action.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "LEADER|ALT",
        action = wt.action.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "LEADER|ALT",
        action = wt.action.ActivatePaneDirection("Right"),
    },
    {
        key = "H",
        mods = "ALT",
        action = wt.action.AdjustPaneSize { "Left", 5 },
    },
    {
        key = "J",
        mods = "ALT",
        action = wt.action.AdjustPaneSize { "Down", 5 },
    },
    {
        key = "K",
        mods = "ALT",
        action = wt.action.AdjustPaneSize { "Up", 5 },
    },
    {
        key = "L",
        mods = "ALT",
        action = wt.action.AdjustPaneSize { "Right", 5 },
    },
    {
        key = "j",
        mods = "ALT",
        action = wt.action.ScrollByLine(1),
    },
    {
        key = "k",
        mods = "ALT",
        action = wt.action.ScrollByLine(-1),
    },
    {
        key = "r",
        mods = "LEADER",
        action = wt.action.RotatePanes("Clockwise")
    },
    {
        key = "R",
        mods = "LEADER",
        action = wt.action.RotatePanes("CounterClockwise")
    },
    {
        key = "s",
        mods = "LEADER",
        action = wt.action.PaneSelect { mode = "SwapWithActiveKeepFocus" }
    },
    -- TAB NAVIGATION
    {
        key = "Tab",
        mods = "CTRL",
        action = wt.action.ActivateTabRelative(1),
    },
    {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = wt.action.ActivateTabRelative(-1),
    },
    {
        key = "w",
        mods = "LEADER|CTRL",
        action = wt.action.CloseCurrentTab { confirm = true },
    },
    {
        key = "t",
        mods = "LEADER|CTRL",
        action = wt.action.SpawnTab("CurrentPaneDomain"),
    },
    -- CLIPBOARD
    {
        key = "C",
        mods = "CTRL",
        action = wt.action.CopyTo(clipboard_location)
    },
    {
        key = "V",
        mods = "CTRL",
        action = wt.action.PasteFrom(clipboard_location)
    },
    -- OTHER
    {
        key = ":",
        mods = "LEADER|SHIFT",
        action = wt.action.ActivateCommandPalette
    },
    {
        key = "/",
        mods = "LEADER",
        action = wt.action.Search { Regex = "" }
    },
    {
        key = "L",
        mods = "CTRL",
        action = wt.action.ShowDebugOverlay
    }
}

M.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wt.action_callback(function(window, pane)
            local selected_text = window:get_selection_text_for_pane(pane)
            if selected_text ~= "" then
                window:perform_action(wt.action.CopyTo(clipboard_location), pane)
                window:perform_action(wt.action.ClearSelection, pane)
            else
                window:perform_action(wt.action.PasteFrom(clipboard_location), pane)
            end
        end)
    },
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = wt.action.CompleteSelection(clipboard_location),
    },
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = wt.action.OpenLinkAtMouseCursor,
    },
}

M.key_tables = {
    search_mode = {
        {
            key = "Enter",
            mods = "NONE",
            action = wt.action.CopyMode("AcceptPattern")
        },
        {
            key = "Escape",
            mods = "NONE",
            action = wt.action.CopyMode("Close")
        },
        {
            key = "n",
            mods = "CTRL",
            action = wt.action.CopyMode("NextMatch")
        },
        {
            key = "N",
            mods = "CTRL",
            action = wt.action.CopyMode("PriorMatch")
        },
        {
            key = "c",
            mods = "CTRL",
            action = wt.action.CopyMode("ClearPattern")
        },
    }
}
M.disable_default_key_bindings = true
M.key_map_preference = "Mapped"

return M
