local hidden = false
local SK = "/opt/homebrew/bin/sketchybar"

local aerospaceSwitcher = require("aerospace_switcher")
hs.hotkey.bind({"alt"}, "space", aerospaceSwitcher.toggle)

local function setMenuBar(visible)
    local val = visible and "false" or "true"
    hs.execute("defaults write NSGlobalDomain _HIHideMenuBar -bool " .. val)
    hs.execute("killall -SIGUSR1 SystemUIServer")
end

local watcher = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, function(e)
    local y = hs.mouse.absolutePosition().y
    if y <= 5 and not hidden then
        hs.execute(SK .. " --bar hidden=on")
        setMenuBar(true)
        hidden = true
    elseif y > 35 and hidden then
        hs.execute(SK .. " --bar hidden=off")
        setMenuBar(false)
        hidden = false
    end
end)
watcher:start()
