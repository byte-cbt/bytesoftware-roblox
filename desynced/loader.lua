--[[
Byte Software - Desynced
---------------------------------
Credits:
  - Byt3c0de (www.byt3c0de.net | @byt3c0de.net)
  - Byte Software (www.bytesoftware.net | discord.gg/bytesoftware)
  - Everyone who has supported me on this journey

I’ve created these scripts and am sharing them openly so that others can learn, experiment, and build amazing projects. 
I hope my code inspires creativity and helps you on your own development journey!

Have fun coding!
]]

if game.CoreGui:FindFirstChild("Library") then
	game.CoreGui:FindFirstChild("Library"):Destroy()
end

local DesyncedLibrary = loadstring(game:HttpGet("https://bytesoftware.net/roblox/desynced/library.lua"))()

local StarterGui = game:GetService("StarterGui")

local uiOpen = true

local placeId = game.PlaceId
local scripts = {
    [3101667897] = "legendsofspeed",
    [3232996272] = "legendsofspeed",
    [3276265788] = "legendsofspeed",
    [3623096087] = "musclelegends",
    [1240123653] = "zombieattack",
    [1632210982] = "zombieattack",
    [3956818381] = "ninjalegends",
    [136200806920326] = "beastgymbattle"
}

local scriptName = scripts[placeId]
if scriptName then
    loadstring(game:HttpGet("https://bytesoftware.net/roblox/desynced/" .. scriptName .. ".lua"))()
end