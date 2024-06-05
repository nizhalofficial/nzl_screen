-- permission.lua
local function hasPermission(source, perm)
    return IsPlayerAceAllowed(source, perm)
end

local function log(message)
    print("[permission.lua] " .. message)
end

AddEventHandler('nzl_screen:checkPermission', function(perm, cb)
    local src = source
    local allowed = hasPermission(src, perm)
    cb(allowed)
end)

RegisterNetEvent('nzl_screen:saveSettings')
AddEventHandler('nzl_screen:saveSettings', function(screenId, settings)
    local src = source
    if not hasPermission(src, "nzl_screen.admin") then
        log("Player " .. GetPlayerName(src) .. " attempted to save settings without permission.")
        return
    end

    log("Saving settings for screen " .. screenId)
    MySQL.Async.execute('REPLACE INTO screen_settings (screen_id, settings) VALUES (@screen_id, @settings)', {
        ['@screen_id'] = screenId,
        ['@settings'] = json.encode(settings)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            log("Settings saved for screen " .. screenId)
            TriggerClientEvent('nzl_screen:settingsSaved', src, true)
        else
            log("Failed to save settings for screen " .. screenId)
            TriggerClientEvent('nzl_screen:settingsSaved', src, false)
        end
    end)
end)

RegisterNetEvent('nzl_screen:getSettings')
AddEventHandler('nzl_screen:getSettings', function(screenId)
    local src = source
    if not hasPermission(src, "nzl_screen.admin") then
        log("Player " .. GetPlayerName(src) .. " attempted to get settings without permission.")
        return
    end

    log("Getting settings for screen " .. screenId)
    MySQL.Async.fetchScalar('SELECT settings FROM screen_settings WHERE screen_id = @screen_id', {
        ['@screen_id'] = screenId
    }, function(result)
        if result then
            local settings = json.decode(result)
            TriggerClientEvent('nzl_screen:loadSettings', src, screenId, settings)
        else
            log("No settings found for screen " .. screenId)
            TriggerClientEvent('nzl_screen:loadSettings', src, screenId, nil)
        end
    end)
end)
