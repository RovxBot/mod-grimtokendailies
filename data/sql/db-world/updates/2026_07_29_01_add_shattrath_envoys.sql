-- Add Grim Token Envoys to Shattrath's Lower City dungeon-daily hub.
-- The source NPCs provide coordinates, phase, and spawn settings that match
-- the local AzerothCore world database.

SET @NPC_ALLIANCE := 900100;
SET @NPC_HORDE := 900101;
SET @SHATTRATH_HEROIC_DAILY := 24369; -- Wind Trader Zhareem
SET @SHATTRATH_NORMAL_DAILY := 24370; -- Nether-Stalker Mah'duun

-- Faction 35 (Friendly) prevents either envoy from aggroing Alliance or Horde players.
UPDATE `creature_template`
SET `faction` = 35
WHERE `entry` IN (@NPC_ALLIANCE, @NPC_HORDE);

-- Keep one Shattrath spawn per envoy, so the update can be safely reapplied.
DELETE FROM `creature`
WHERE `id` IN (@NPC_ALLIANCE, @NPC_HORDE)
  AND `map` = 530
  AND `zoneId` = 3703;

-- Alliance envoy: beside Wind Trader Zhareem outside World's End Tavern.
INSERT INTO `creature`
  (`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
   `position_x`, `position_y`, `position_z`, `orientation`,
   `spawntimesecs`, `wander_distance`, `currentwaypoint`,
   `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
   `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
  @NPC_ALLIANCE, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
  `position_x` + 2.0, `position_y`, `position_z`, `orientation`,
  `spawntimesecs`, 0, `currentwaypoint`,
  `curhealth`, `curmana`, `MovementType`, 0, `unit_flags`, `dynamicflags`,
  `ScriptName`, `VerifiedBuild`, `CreateObject`, 'Grim Token questgiver (Shattrath Alliance)'
FROM `creature`
WHERE `id` = @SHATTRATH_HEROIC_DAILY
ORDER BY `guid`
LIMIT 1;

-- Horde envoy: beside Nether-Stalker Mah'duun outside World's End Tavern.
INSERT INTO `creature`
  (`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
   `position_x`, `position_y`, `position_z`, `orientation`,
   `spawntimesecs`, `wander_distance`, `currentwaypoint`,
   `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
   `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
  @NPC_HORDE, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
  `position_x` - 2.0, `position_y`, `position_z`, `orientation`,
  `spawntimesecs`, 0, `currentwaypoint`,
  `curhealth`, `curmana`, `MovementType`, 0, `unit_flags`, `dynamicflags`,
  `ScriptName`, `VerifiedBuild`, `CreateObject`, 'Grim Token questgiver (Shattrath Horde)'
FROM `creature`
WHERE `id` = @SHATTRATH_NORMAL_DAILY
ORDER BY `guid`
LIMIT 1;
