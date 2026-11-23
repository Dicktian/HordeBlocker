-- HordeBlocker 1.2 | World of Warcraft 3.3.5a
-- Automatic, no commands, no settings, no external dependencies.

local function isOrcish(language)
    if type(language) == "number" then
        return language == 1 -- LANGUAGE_ORCISH
    end
    if type(language) ~= "string" then return false end
    local clean = language:lower():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    clean = clean:gsub("^%s+", ""):gsub("%s+$", "")
    clean = clean:gsub("^%[", ""):gsub("%]$", "")
    return clean == "orcish" or clean == "orco" or clean == "orc" or clean == "orcico" or clean == "orcish language"
end

-- The first extra CHAT_MSG_SAY/YELL argument is the message language.
-- Do not scan unrelated arguments: numeric flags may equal language ID 1.
local function filterChat(_, _, message, sender, language)
    if UnitFactionGroup("player") ~= "Alliance" then return false end
    if isOrcish(language) then return true end
    -- Some private-server cores include the language tag in the raw message.
    if type(message) == "string" and message:match("^%s*%[[Oo][Rr][Cc][Oo]%]") then
        return true
    end
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filterChat)

-- Compatibility fallback for private-server clients that inject the language
-- into the already formatted chat line, bypassing the normal language field.
local function isRenderedHordeChat(message)
    if type(message) ~= "string" then return false end
    local clean = message:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    if not clean:find("%[[Oo][Rr][Cc][Oo]%]") then return false end
    local lower = clean:lower()
    return lower:find("grita:", 1, true) ~= nil
        or lower:find("dice:", 1, true) ~= nil
        or lower:find("yells:", 1, true) ~= nil
        or lower:find("says:", 1, true) ~= nil
end

local function attachFrame(frame)
    if not frame or frame.HordeBlockerHooked then return end
    frame.HordeBlockerHooked = true
    local original = frame.AddMessage
    frame.AddMessage = function(self, message, ...)
        if UnitFactionGroup("player") == "Alliance" and isRenderedHordeChat(message) then
            return
        end
        return original(self, message, ...)
    end
end

local function attachChatFrames()
    for i = 1, (NUM_CHAT_WINDOWS or 10) do
        attachFrame(_G["ChatFrame" .. i])
    end
end

attachChatFrames()
local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:RegisterEvent("UPDATE_CHAT_WINDOWS")
loader:SetScript("OnEvent", attachChatFrames)
