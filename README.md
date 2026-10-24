# Recount for Grimfall

Recount r1127 for the Grimfall WoW 3.3.5 client, with Greater Skeletal Warrior ownership support built in. One addon folder; no companion addon required.

**[Download Recount-Grimfall.zip](https://github.com/GrimfallAddonFixes/recount-grimfall/raw/refs/heads/main/downloads/Recount-Grimfall.zip)**

## Install

1. Close WoW completely.
2. Download **Recount-Grimfall.zip** using the link above (not GitHub's source-code ZIP).
3. Extract the **Recount** folder into your game client's `Interface/AddOns` folder, replacing existing Recount addon files.
4. If you previously installed **RecountGrimfallSummons**, remove that separate addon folder.
5. Restart WoW and enable Recount. Your existing settings in `WTF` are preserved.
6. Summon fresh Greater Skeletal Warriors while the players using the meter are grouped and nearby.

Use **Merge Pets w/ Owners** in Recount to include pet damage in the owner's total. The tooltip lists the warriors' contribution separately; the player's ability detail window still shows the player's own attacks.

Install this on each computer that needs the corrected meter. Installing it only on the summoner's computer does not patch another player's meter.

## What changed

Grimfall's Greater Skeletal Warriors apply ownership aura **807927** to their summoner instead of emitting the standard `SPELL_SUMMON` event in the captured test. The integrated `GrimfallSummons.lua` file translates that specific signal into Recount's existing summon registration path. It uses unit GUIDs, not a hard-coded character name.

The fix is limited to **Greater Skeletal Warrior (NPC 4335)**. It does not reconstruct past fights or claim support for other summon types. Reinstalling an upstream Recount version can remove the compatibility change.

## Validation

A diagnostic recording contained four warriors and 18 melee hits totaling 1,035 raw damage. Lua 5.1 replay tests against Recount's parser verified ownership for the summoner and simulated party/raid affiliations. A live user test confirmed the warrior contribution appeared in the tooltip and merged total. Broader server and multi-player combinations may still need testing.

## Credits

Original Recount authors are credited in `Recount/Recount.toc` and the original source. Bundled libraries retain their original notices. This is an unofficial community compatibility modification, not an official Grimfall release. No new license is asserted over the upstream addon or bundled libraries.

Please include your Recount version, which summon was affected, and reproduction steps when reporting a problem. Avoid uploading account folders or personal saved data publicly.
