-- client/client.lua
local function log(message)
    print("[client/client.lua] " .. message)
end

RegisterCommand('nzl_screen', function()
    TriggerServerEvent('nzl_screen:checkPermission', "nzl_screen.admin", function(allowed)
        if allowed then
            log("Opening UI")
            -- Display the UI to select a screen and play a video
            SendNUIMessage({ action = 'open' })
            SetNuiFocus(true, true)
        else
            log("Permission denied.")
        end
    end)
end, false)

RegisterCommand('nzl_screen volume', function(source, args)
    local volume = tonumber(args[1])
    if volume then
        log("Setting volume to " .. volume)
        SendNUIMessage({ action = 'setVolume', volume = volume })
    end
end, false)

RegisterNUICallback('play', function(data, cb)
    log("Playing video on screen " .. data.screenId .. " with URL " .. data.url)
    -- Logic to play the video on the selected screen
    local screenId = data.screenId
    local url = data.url
    PlayVideoOnScreen(screenId, url)
    cb('ok')
end)

function PlayVideoOnScreen(screenId, url)
    log("Playing video on screen " .. screenId .. " with URL " .. url)
    -- Example function to handle the actual video playback
    -- Implementation will vary depending on how you handle Scaleform and RenderTargets
    -- You can use a native function to create a render target and display the video
end

RegisterNetEvent('nzl_screen:settingsSaved')
AddEventHandler('nzl_screen:settingsSaved', function(success)
    if success then
        log("Settings were successfully saved.")
    else
        log("Failed to save settings.")
    end
end)

RegisterNetEvent('nzl_screen:loadSettings')
AddEventHandler('nzl_screen:loadSettings', function(screenId, settings)
    if settings then
        log("Loaded settings for screen " .. screenId)
        -- Apply the loaded settings to the screen
    else
        log("No settings found for screen " .. screenId)
    end
end)
