-- Popup overview of AeroSpace workspaces 1-10: which apps/windows live where.
-- Toggle with the hotkey bound in init.lua.
-- j/k moves the selection, enter/space jumps to it, escape closes.

local M = {}

local AEROSPACE = "/opt/homebrew/bin/aerospace"
local MAX_WORKSPACE = 10

local IDLE_FILL = { white = 1, alpha = 0.05 }
local IDLE_STROKE = { white = 1, alpha = 0.16 }
local SEL_FILL = { white = 1, alpha = 0.22 }
local SEL_STROKE = { white = 1, alpha = 0.95 }

local canvas = nil
local keyWatcher = nil
local rows = {} -- ordered { ws = <num>, rectIndex = <canvas element index> }
local selected = 1

local function getFocusedWorkspace()
    local out = hs.execute(AEROSPACE .. " list-workspaces --focused --format '%{workspace}'")
    return tonumber(out:match("%d+"))
end

local function parseWindows()
    local out = hs.execute(AEROSPACE ..
        " list-windows --all --format '%{workspace}|%{app-name}|%{window-id}|%{app-bundle-id}'")
    local byWorkspace = {}
    for line in out:gmatch("[^\r\n]+") do
        local ws, app, winID, bundleID = line:match("^(.-)|(.-)|(.-)|(.*)$")
        local wsNum = tonumber(ws)
        if wsNum and wsNum >= 1 and wsNum <= MAX_WORKSPACE then
            byWorkspace[wsNum] = byWorkspace[wsNum] or {}
            table.insert(byWorkspace[wsNum], { app = app, winID = winID, bundleID = bundleID })
        end
    end
    local ordered = {}
    for wsNum, windows in pairs(byWorkspace) do
        table.insert(ordered, { ws = wsNum, windows = windows })
    end
    table.sort(ordered, function(a, b) return a.ws < b.ws end)
    return ordered
end

local function closePopup()
    if canvas then
        canvas:delete()
        canvas = nil
    end
    if keyWatcher then
        keyWatcher:stop()
        keyWatcher = nil
    end
    rows = {}
    selected = 1
end

local function setSelected(newIndex)
    if #rows == 0 then return end
    newIndex = ((newIndex - 1) % #rows) + 1
    if rows[selected] then
        canvas[rows[selected].rectIndex].fillColor = IDLE_FILL
        canvas[rows[selected].rectIndex].strokeColor = IDLE_STROKE
        canvas[rows[selected].rectIndex].strokeWidth = 1
    end
    selected = newIndex
    canvas[rows[selected].rectIndex].fillColor = SEL_FILL
    canvas[rows[selected].rectIndex].strokeColor = SEL_STROKE
    canvas[rows[selected].rectIndex].strokeWidth = 2
end

local function jumpToSelected()
    local row = rows[selected]
    if row then
        hs.execute(AEROSPACE .. " workspace " .. row.ws)
    end
    closePopup()
end

local function buildPopup(data)
    local W = 380
    local MARGIN = 14
    local ROW_PAD_V = 10
    local LINE_H = 22
    local ICON = 16
    local BADGE_W = 46
    local GAP = 8

    -- background panel reserved as element 1; frame patched once H is known
    local elements = { {
        type = "rectangle",
        action = "strokeAndFill",
        fillColor = { white = 0.05, alpha = 0.85 },
        strokeColor = { white = 1, alpha = 0.18 },
        strokeWidth = 1,
        roundedRectRadii = { xRadius = 16, yRadius = 16 },
        frame = { x = 0, y = 0, w = W, h = 0 },
    } }

    local rowsMeta = {}
    local y = MARGIN

    for _, entry in ipairs(data) do
        local rowH = (#entry.windows * LINE_H) + (2 * ROW_PAD_V)

        table.insert(elements, {
            type = "rectangle",
            action = "strokeAndFill",
            fillColor = IDLE_FILL,
            strokeColor = IDLE_STROKE,
            strokeWidth = 1,
            roundedRectRadii = { xRadius = 10, yRadius = 10 },
            frame = { x = MARGIN, y = y, w = W - 2 * MARGIN, h = rowH },
            trackMouseUp = true,
            id = "ws" .. entry.ws,
        })
        table.insert(rowsMeta, { ws = entry.ws, rectIndex = #elements })

        table.insert(elements, {
            type = "text",
            text = tostring(entry.ws),
            textFont = ".AppleSystemUIFontBold",
            textSize = 18,
            textColor = { white = 1, alpha = 0.9 },
            textAlignment = "center",
            frame = { x = MARGIN, y = y + rowH / 2 - 13, w = BADGE_W, h = 26 },
        })

        for i, win in ipairs(entry.windows) do
            local lineY = y + ROW_PAD_V + (i - 1) * LINE_H
            local icon = win.bundleID ~= "" and hs.image.imageFromAppBundle(win.bundleID) or nil
            if icon then
                table.insert(elements, {
                    type = "image",
                    image = icon,
                    frame = { x = MARGIN + BADGE_W, y = lineY + (LINE_H - ICON) / 2, w = ICON, h = ICON },
                })
            end
            table.insert(elements, {
                type = "text",
                text = win.app,
                textFont = ".AppleSystemUIFont",
                textSize = 13,
                textColor = { white = 1, alpha = 0.9 },
                frame = {
                    x = MARGIN + BADGE_W + ICON + 8,
                    y = lineY + 2,
                    w = W - 2 * MARGIN - BADGE_W - ICON - 8 - 10,
                    h = LINE_H,
                },
            })
        end

        y = y + rowH + GAP
    end

    local H = y - GAP + MARGIN
    elements[1].frame = { x = 0, y = 0, w = W, h = H }

    local screenFrame = hs.mouse.getCurrentScreen():frame()
    local x = screenFrame.x + (screenFrame.w - W) / 2
    local topY = screenFrame.y + (screenFrame.h - H) / 2

    local c = hs.canvas.new({ x = x, y = topY, w = W, h = H })
    c:level(hs.canvas.windowLevels.popUpMenu)
    c:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
    for i, el in ipairs(elements) do c[i] = el end

    c:mouseCallback(function(_, event, id)
        if event == "mouseUp" and id then
            local ws = id:match("^ws(%d+)$")
            if ws then
                for i, row in ipairs(rowsMeta) do
                    if row.ws == tonumber(ws) then
                        selected = i
                        break
                    end
                end
                jumpToSelected()
            end
        end
    end)

    c:show()
    return c, rowsMeta
end

function M.toggle()
    if canvas then
        closePopup()
        return
    end

    local data = parseWindows()
    if #data == 0 then return end

    canvas, rows = buildPopup(data)
    selected = 0

    local focusedWs = getFocusedWorkspace()
    local startIndex = 1
    for i, row in ipairs(rows) do
        if row.ws == focusedWs then
            startIndex = i
            break
        end
    end
    setSelected(startIndex)

    keyWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(e)
        local code = e:getKeyCode()
        if code == hs.keycodes.map["escape"] then
            closePopup()
            return true
        elseif code == hs.keycodes.map["j"] or code == hs.keycodes.map["down"] then
            setSelected(selected + 1)
            return true
        elseif code == hs.keycodes.map["k"] or code == hs.keycodes.map["up"] then
            setSelected(selected - 1)
            return true
        elseif code == hs.keycodes.map["return"] or code == hs.keycodes.map["space"] then
            jumpToSelected()
            return true
        end
        return false
    end)
    keyWatcher:start()
end

return M
