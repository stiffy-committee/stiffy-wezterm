local M = {}
local wt = require("wezterm")

function M.is_windows()
    return package.config:sub(1, 1) == "\\"
end

function M.get_powershell()
    local pwsh7_path = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
    local pwsh_default_path = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"

    local file = io.open(pwsh7_path, "r")
    if file then
        file:close()
        return pwsh7_path
    else
        return pwsh_default_path
    end
end

function M.merge_tables(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
        wt.log_error("trying to merge non-table types, returning unmodified table")
        return a
    end
    for k, v in pairs(b) do
        if type(v) == "table" and type(a[k]) == "table" then
            M.merge_tables(a[k], v)
        else
            a[k] = v
        end
    end
    return a
end

function M.get_config_dir()
    local base_path = ""
    if M.is_windows() then
        base_path = os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH")
    else
        base_path = os.getenv("HOME")
    end
    base_path = base_path .. "/.config/wezterm/"
    return base_path
end

return M
