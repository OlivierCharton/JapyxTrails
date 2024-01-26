-- List of the map ID's we have markers on in
Japyx.maps = {375, 248, 650}

-- Table to store all the important stuff
Japyx.info = {
    firstTime = "true",
    shown = false,
    marker = nil,
    markerOrigin = nil
}

-- Watch let's us see the table in real-time in the script console
Debug:Watch("JapyxInfo", Japyx.info)

-- These are constants that you can change however you want
INFO_TEXT = "This pack is not optimized for Glyph of Reaping. If you have it, you can use other spots to go faster \n\r\n\r\n\rSpecial thanks :\n\r  - Teh for his Marker Pack Academy and the scripting\n\r  - QuitarHero for making this trail beautiful"
MAX_DISTANCE_FROM_PLAYER = 10
MARKER_TEXTURE_PATH = "Data/JapyxTrails/Markers/caution.png"

-- This is run when this script is loaded, reading the stored value
local firstTime = Storage:ReadValue("Japyx", "firstTime")
if firstTime ~= nil then
    Japyx.info.firstTime = firstTime
end

-- -- This is the function that shows the info marker
local function show_info()
    -- Get the players current position to use as the marker pos
    Japyx.info.markerOrigin = Mumble.PlayerCharacter.Position
    local markerAttributes = {
        -- Ensuring we flip the Y and Z
        xpos = Japyx.info.markerOrigin.X,
        ypos = Japyx.info.markerOrigin.Z,
        zpos = Japyx.info.markerOrigin.Y,
        AutoTrigger = true,
        Info = INFO_TEXT,
        TriggerRange = 5,
        InGameVisibility = false,
        MiniMapVisibility = false,
        MapVisibility = false,
        iconFile = MARKER_TEXTURE_PATH
    }
    -- Create the marker with the above attributes
    Japyx.info.marker = Pack:CreateMarker(markerAttributes)
    Japyx.info.shown = true

    -- Store the false value for future times
    Storage:UpsertValue("Japyx", "firstTime", "false")
end

-- This function removes the marker and does other cleanup
local function info_hide()
    Japyx.info.marker:Remove()
    Japyx.info.markerOrigin = nil
    Japyx.info.shown = false
end

-- Click function to show the info just in case people want to reshow it
local function info_click(menu)
    show_info()
end

-- Building the menu for the click function
local mainMenu = Menu:Add("JapyxTrails", nil)
local si = mainMenu:Add("Show info", info_click, false, false, "Shows the pack info text.")

-- Tick handler that watches for the player to move out of range of the marker, once they do, it removes the marker
local function tick_handler(gameTime)
    if Japyx.info.shown == true then
        if ((Mumble.PlayerCharacter.Position - Japyx.info.markerOrigin):Length() > MAX_DISTANCE_FROM_PLAYER) then
            info_hide()
        end
    end
end

-- Set the tick handler
Event:OnTick(tick_handler)

-- Returns true if a map ID is in the table of ID's
local function mapIsIn(table, val)
    for _, v in ipairs(table) do
        if (v == val) then
            return true
        end
    end

    return false
end

-- Finally, once all is loaded, if this is the first time, then show the info
if Japyx.info.firstTime == "true" then
    local mapID = Mumble.CurrentMap.Id
    local maps = Japyx.maps
    if (mapIsIn(maps, mapID)) then
        show_info()
    end
end