-- Grimfall 3.3.5: Greater Skeletal Warriors (NPC 4335) apply aura 807927
-- to their summoner instead of producing SPELL_SUMMON. Translate this
-- ownership signal into Recount's existing summon registration path.
local Recount = _G.Recount
if not Recount or type(Recount.CombatLogEvent) ~= "function" then return end
local original = Recount.CombatLogEvent
local band, bor, bnot = bit.band, bit.bor, bit.bnot

function Recount:CombatLogEvent(event, timestamp, eventtype,
    srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
    local spellId = ...
    if (eventtype == "SPELL_AURA_APPLIED" or eventtype == "SPELL_AURA_REFRESH")
        and spellId == 807927
        and type(srcGUID) == "string"
        and tonumber(srcGUID:sub(-12, -7), 16) == 4335
        and srcName and dstGUID and dstName
        and type(srcFlags) == "number" and type(dstFlags) == "number"
        and band(srcFlags, 0x3000) ~= 0 -- Pet or guardian
        and band(dstFlags, 0x0400) ~= 0 -- Owner must be a player
        and band(dstFlags, 0x0010) ~= 0 then -- Friendly owner
        -- These multi-summons have no normal pet unit token. Register them
        -- as guardians to avoid Recount's single-pet unit lookup.
        local guardianFlags = bor(band(srcFlags, bnot(0xFC00)), 0x2000)
        original(self, event, timestamp, "SPELL_SUMMON",
            dstGUID, dstName, dstFlags, srcGUID, srcName, guardianFlags, ...)
    end
    -- Preserve the original event and its exact arguments for normal tracking.
    return original(self, event, timestamp, eventtype,
        srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
end
