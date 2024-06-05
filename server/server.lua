-- server/server.lua
dofile('permission.lua')  -- Add this line to include the permissions script

local function log(message)
    print("[server/server.lua] " .. message)
end

MySQL.ready(function ()
    log("Database connected.")
end)
