local spaces = require("hs._asm.undocumented.spaces")

opt = {"option"}
shiftopt = {"shift", "option"}
frontwins = {}

function firstFocus(spaceID)
    local wins = spaces.allWindowsForSpace(spaceID)
    for i, data in pairs(wins) do
        data:focus()
        break
    end
end

function SwitchSpace(sp)
    -- Switch space IMMEDIATELY!!!
    local uuid
    for index, data in pairs(spaces.spacesByScreenUUID()) do
        if #data > 1 then
            uuid = index
            break
        end
    end
    local activeSpace = spaces.activeSpace()
    frontwins[activeSpace] = hs.window.frontmostWindow()
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.changeToSpace(spaceID, false)

    if frontwins[spaceID] ~= nil then
        for index, data in pairs(spaces.allWindowsForSpace(spaceID)) do
            if data == frontwins[spaceID] then
                frontwins[spaceID]:focus()
                return
            end
        end
    end

    firstFocus(spaceID)
end

-- move current window to the space sp
function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local otherwins = win:otherWindowsSameScreen()
    swin = -1
    for i, key in pairs(otherwins) do
        if i == 2 then
            swin = key
        end
    end
    if swin ~= -1 then
        swin:focus()
    end
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
    frontwins[spaceID] = win
end

hs.hotkey.bind(opt, '1', function() SwitchSpace(1) end)
hs.hotkey.bind(opt, '2', function() SwitchSpace(2) end)
hs.hotkey.bind(opt, '3', function() SwitchSpace(3) end)
hs.hotkey.bind(opt, '4', function() SwitchSpace(4) end)
hs.hotkey.bind(opt, '5', function() SwitchSpace(5) end)
hs.hotkey.bind(opt, '6', function() SwitchSpace(6) end)
hs.hotkey.bind(opt, '7', function() SwitchSpace(7) end)
hs.hotkey.bind(opt, '8', function() SwitchSpace(8) end)
hs.hotkey.bind(opt, '9', function() SwitchSpace(9) end)
hs.hotkey.bind(opt, '0', function() SwitchSpace(10) end)

hs.hotkey.bind(shiftopt, '1', function() MoveWindowToSpace(1) end)
hs.hotkey.bind(shiftopt, '2', function() MoveWindowToSpace(2) end)
hs.hotkey.bind(shiftopt, '3', function() MoveWindowToSpace(3) end)
hs.hotkey.bind(shiftopt, '4', function() MoveWindowToSpace(4) end)
hs.hotkey.bind(shiftopt, '5', function() MoveWindowToSpace(5) end)
hs.hotkey.bind(shiftopt, '6', function() MoveWindowToSpace(6) end)
hs.hotkey.bind(shiftopt, '7', function() MoveWindowToSpace(7) end)
hs.hotkey.bind(shiftopt, '8', function() MoveWindowToSpace(8) end)
hs.hotkey.bind(shiftopt, '9', function() MoveWindowToSpace(9) end)
hs.hotkey.bind(shiftopt, '0', function() MoveWindowToSpace(10) end)
