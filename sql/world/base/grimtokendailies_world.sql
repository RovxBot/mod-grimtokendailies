-- =========================================================
-- mod-GrimTokenDailies — World Database Setup
-- =========================================================
-- Runs once when the module is first installed.
-- Creates items, NPCs, quests, quest relations, and boss
-- loot for the Grim Token daily-dungeon system.
-- =========================================================

-- ---------------------
-- Configuration IDs
-- ---------------------
SET @TOKEN_ITEM_ID       := 90000;
SET @CLASSIC_DUTY_ITEM   := 90001;
SET @TBC_DUTY_ITEM       := 90002;

SET @QUEST_CLASSIC       := 210010;
SET @QUEST_TBC           := 210011;

SET @NPC_ALLIANCE        := 900100;
SET @NPC_HORDE           := 900101;

SET @SW_GUARD            := 1423;   -- Stormwind Guard (template to clone)
SET @ORG_GRUNT           := 3296;   -- Orgrimmar Grunt  (template to clone)

-- Stormwind spawn
SET @SW_X     := -8787.98;
SET @SW_Y     := 640.276;
SET @SW_Z     := 69.1281;
SET @SW_O     := 3.09639;
SET @SW_ZONE  := 1519;
SET @SW_AREA  := 1519;
SET @SW_PHASE := 1;

-- Orgrimmar spawn
SET @ORG_X     := 1651.4655;
SET @ORG_Y     := -4434.145;
SET @ORG_Z     := 17.602255;
SET @ORG_O     := 1.7898299;
SET @ORG_ZONE  := 1637;
SET @ORG_AREA  := 1637;
SET @ORG_PHASE := 4294967295;

-- =========================================================
-- 1. ITEMS
-- =========================================================
INSERT IGNORE INTO `item_template`
  (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`,
   `bonding`, `stackable`, `maxcount`, `BuyPrice`, `SellPrice`, `description`)
VALUES
  (@TOKEN_ITEM_ID,     10, 0, 'Grim Token',          32621,  2, 1, 1000, 0, 0, 1,
   'Earned from daily dungeon quests. Used for vanity rewards in the portal store.'),
  (@CLASSIC_DUTY_ITEM, 12, 0, 'Dungeon Duty Mark',   6265,   1, 1, 1, 1, 0, 0,
   'Taken from the final boss of any classic dungeon.'),
  (@TBC_DUTY_ITEM,     12, 0, 'Faction Service Mark', 6266,   1, 1, 1, 1, 0, 0,
   'Taken from the final boss of any Outland dungeon.');

-- Normalise token properties in case the row already existed
UPDATE `item_template`
  SET `bonding` = 1, `SellPrice` = 1, `BuyPrice` = 0, `stackable` = 1000
  WHERE `entry` = @TOKEN_ITEM_ID;

-- =========================================================
-- 2. HEROIC PROOF-OF-DEMISE QUEST REWARDS  (5 tokens each)
-- =========================================================
UPDATE `quest_template`
  SET `RewardItem1` = @TOKEN_ITEM_ID, `RewardAmount1` = 5
  WHERE `ID` IN (13245,13246,13247,13248,13249,13250,
                 13251,13252,13253,13254,13255,13256,14199);

-- =========================================================
-- 3. QUESTGIVER NPCs  (cloned from faction guards)
-- =========================================================
-- Alliance NPC — cloned from Stormwind Guard
INSERT INTO `creature_template`
  (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
   `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`,
   `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`,
   `npcflag`,
   `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
   `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`,
   `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`,
   `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
   `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`,
   `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`,
   `AIName`, `MovementType`,
   `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`,
   `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`,
   `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`,
   `ScriptName`, `VerifiedBuild`)
SELECT
  @NPC_ALLIANCE,
  `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
  `KillCredit1`, `KillCredit2`,
  'Grim Token Envoy', 'Daily Dungeon Rewards', `IconName`,
  `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`,
  2, -- UNIT_NPC_FLAG_QUESTGIVER
  `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
  `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`,
  `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`,
  `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
  `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`,
  `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`,
  `AIName`, `MovementType`,
  `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`,
  `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`,
  `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`,
  `ScriptName`, `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = @SW_GUARD
  AND NOT EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = @NPC_ALLIANCE);

-- Horde NPC — cloned from Orgrimmar Grunt
INSERT INTO `creature_template`
  (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
   `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`,
   `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`,
   `npcflag`,
   `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
   `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`,
   `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`,
   `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
   `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`,
   `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`,
   `AIName`, `MovementType`,
   `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`,
   `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`,
   `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`,
   `ScriptName`, `VerifiedBuild`)
SELECT
  @NPC_HORDE,
  `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
  `KillCredit1`, `KillCredit2`,
  'Grim Token Envoy', 'Daily Dungeon Rewards', `IconName`,
  `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`,
  2, -- UNIT_NPC_FLAG_QUESTGIVER
  `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
  `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`,
  `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`,
  `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`,
  `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`,
  `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`,
  `AIName`, `MovementType`,
  `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`,
  `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`,
  `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`,
  `ScriptName`, `VerifiedBuild`
FROM `creature_template`
WHERE `entry` = @ORG_GRUNT
  AND NOT EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = @NPC_HORDE);

-- =========================================================
-- 4. NPC MODELS  (clone display data from guards)
-- =========================================================
DELETE FROM `creature_template_model` WHERE `CreatureID` = @NPC_ALLIANCE;
INSERT INTO `creature_template_model`
  (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT @NPC_ALLIANCE, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = @SW_GUARD;

DELETE FROM `creature_template_model` WHERE `CreatureID` = @NPC_HORDE;
INSERT INTO `creature_template_model`
  (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT @NPC_HORDE, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = @ORG_GRUNT;

-- =========================================================
-- 5. NPC SPAWNS  (Stormwind & Orgrimmar)
-- =========================================================
-- Alliance spawn — Stormwind
INSERT INTO `creature`
  (`id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
   `position_x`, `position_y`, `position_z`, `orientation`,
   `spawntimesecs`, `wander_distance`, `currentwaypoint`,
   `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
   `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
  @NPC_ALLIANCE, `id2`, `id3`, 0, @SW_ZONE, @SW_AREA, `spawnMask`, @SW_PHASE, `equipment_id`,
  @SW_X, @SW_Y, @SW_Z, @SW_O,
  `spawntimesecs`, 0, `currentwaypoint`,
  `curhealth`, `curmana`, `MovementType`, 0, `unit_flags`, `dynamicflags`,
  `ScriptName`, `VerifiedBuild`, `CreateObject`, 'Grim Token questgiver (SW)'
FROM `creature`
WHERE `id1` = @SW_GUARD
  AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id1` = @NPC_ALLIANCE)
ORDER BY `guid`
LIMIT 1;

UPDATE `creature`
SET `map` = 0,
    `zoneId`    = @SW_ZONE,
    `areaId`    = @SW_AREA,
    `phaseMask` = @SW_PHASE,
    `position_x`  = @SW_X,
    `position_y`  = @SW_Y,
    `position_z`  = @SW_Z,
    `orientation` = @SW_O,
    `wander_distance` = 0
WHERE `id1` = @NPC_ALLIANCE;

-- Horde spawn — Orgrimmar
INSERT INTO `creature`
  (`id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
   `position_x`, `position_y`, `position_z`, `orientation`,
   `spawntimesecs`, `wander_distance`, `currentwaypoint`,
   `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`,
   `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
SELECT
  @NPC_HORDE, `id2`, `id3`, 1, @ORG_ZONE, @ORG_AREA, `spawnMask`, @ORG_PHASE, `equipment_id`,
  @ORG_X, @ORG_Y, @ORG_Z, @ORG_O,
  `spawntimesecs`, 0, `currentwaypoint`,
  `curhealth`, `curmana`, `MovementType`, 0, `unit_flags`, `dynamicflags`,
  `ScriptName`, `VerifiedBuild`, `CreateObject`, 'Grim Token questgiver (Org)'
FROM `creature`
WHERE `id1` = @ORG_GRUNT
  AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id1` = @NPC_HORDE)
ORDER BY `guid`
LIMIT 1;

UPDATE `creature`
SET `map` = 1,
    `zoneId`    = @ORG_ZONE,
    `areaId`    = @ORG_AREA,
    `phaseMask` = @ORG_PHASE,
    `position_x`  = @ORG_X,
    `position_y`  = @ORG_Y,
    `position_z`  = @ORG_Z,
    `orientation` = @ORG_O,
    `wander_distance` = 0
WHERE `id1` = @NPC_HORDE;

-- =========================================================
-- 6. DAILY QUESTS
-- =========================================================
INSERT INTO `quest_template`
  (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`,
   `SuggestedGroupNum`, `Flags`,
   `RewardXPDifficulty`, `RewardMoney`,
   `RewardItem1`, `RewardAmount1`,
   `RequiredItemId1`, `RequiredItemCount1`,
   `LogTitle`, `LogDescription`, `QuestDescription`, `QuestCompletionLog`,
   `ObjectiveText1`)
VALUES
  (
    @QUEST_CLASSIC,
    2,       -- QuestType  (daily)
    -1,      -- QuestLevel (scales)
    15,      -- MinLevel
    206,     -- QuestSortID (Dungeon)
    85,      -- QuestInfoID
    5,       -- SuggestedGroupNum
    4232,    -- Flags (DAILY | STAY_AFTER_COMPLETE | PARTY_ACCEPT)
    8,       -- RewardXPDifficulty
    0,       -- RewardMoney
    @TOKEN_ITEM_ID, 1,
    @CLASSIC_DUTY_ITEM, 1,
    'Doing Your Duty',
    'The Grim Token Envoy has a daily task for you: clear a classic dungeon and bring back proof of victory.',
    'The Envoy keeps the realm safe by marking the deeds of its champions. Join a Dungeon Finder run for a classic dungeon, defeat the final boss, and recover a Dungeon Duty Mark as proof. Return to claim your reward.',
    'Well done. The Envoy marks your service to the realm.',
    'Recover a Dungeon Duty Mark from a classic dungeon''s final boss.'
  ),
  (
    @QUEST_TBC,
    2,       -- QuestType  (daily)
    -1,      -- QuestLevel (scales)
    61,      -- MinLevel
    206,     -- QuestSortID (Dungeon)
    85,      -- QuestInfoID
    5,       -- SuggestedGroupNum
    4232,    -- Flags
    8,       -- RewardXPDifficulty
    0,       -- RewardMoney
    @TOKEN_ITEM_ID, 2,
    @TBC_DUTY_ITEM, 1,
    'Service to Your Faction',
    'The Envoy calls for Outland veterans to prove their service and earn their tokens.',
    'The armies of Outland still need stalwart allies. Enter any Outland dungeon via the Dungeon Finder, defeat the final boss, and recover a Faction Service Mark as proof. Return to claim your reward.',
    'Your service brings honor to your faction.',
    'Recover a Faction Service Mark from an Outland dungeon''s final boss.'
  )
ON DUPLICATE KEY UPDATE
  `QuestLevel`         = VALUES(`QuestLevel`),
  `MinLevel`           = VALUES(`MinLevel`),
  `QuestSortID`        = VALUES(`QuestSortID`),
  `QuestInfoID`        = VALUES(`QuestInfoID`),
  `RewardXPDifficulty` = VALUES(`RewardXPDifficulty`),
  `RewardMoney`        = VALUES(`RewardMoney`),
  `RewardItem1`        = VALUES(`RewardItem1`),
  `RewardAmount1`      = VALUES(`RewardAmount1`),
  `RequiredItemId1`    = VALUES(`RequiredItemId1`),
  `RequiredItemCount1` = VALUES(`RequiredItemCount1`),
  `Flags`              = VALUES(`Flags`),
  `LogTitle`           = VALUES(`LogTitle`),
  `LogDescription`     = VALUES(`LogDescription`),
  `QuestDescription`   = VALUES(`QuestDescription`),
  `QuestCompletionLog` = VALUES(`QuestCompletionLog`),
  `ObjectiveText1`     = VALUES(`ObjectiveText1`);

-- =========================================================
-- 7. QUEST RELATIONS  (link quests ↔ NPCs)
-- =========================================================
INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`) VALUES
  (@NPC_ALLIANCE, @QUEST_CLASSIC),
  (@NPC_HORDE,    @QUEST_CLASSIC),
  (@NPC_ALLIANCE, @QUEST_TBC),
  (@NPC_HORDE,    @QUEST_TBC);

INSERT IGNORE INTO `creature_questender` (`id`, `quest`) VALUES
  (@NPC_ALLIANCE, @QUEST_CLASSIC),
  (@NPC_HORDE,    @QUEST_CLASSIC),
  (@NPC_ALLIANCE, @QUEST_TBC),
  (@NPC_HORDE,    @QUEST_TBC);

-- =========================================================
-- 8. BOSS LOOT — Classic dungeon final bosses
-- =========================================================
-- Duty marks are QuestRequired=1, so they only drop while the
-- player has the corresponding daily quest active.
INSERT INTO `creature_loot_template`
  (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`,
   `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
  ie.`creditEntry`,
  @CLASSIC_DUTY_ITEM,
  0,        -- Reference
  100,      -- Chance
  1,        -- QuestRequired
  1,        -- LootMode
  0,        -- GroupId
  1,        -- MinCount
  1,        -- MaxCount
  'Grim classic duty mark'
FROM `instance_encounters` ie
JOIN `creature_template` ct ON ct.`entry` = ie.`creditEntry`
WHERE ie.`lastEncounterDungeon` != 0
  AND ie.`creditType` = 0
  AND ct.`exp` = 0
  AND ie.`lastEncounterDungeon` NOT IN (42,48,50,160,161)
ON DUPLICATE KEY UPDATE
  `Chance`        = VALUES(`Chance`),
  `QuestRequired` = VALUES(`QuestRequired`),
  `LootMode`      = VALUES(`LootMode`),
  `GroupId`       = VALUES(`GroupId`),
  `MinCount`      = VALUES(`MinCount`),
  `MaxCount`      = VALUES(`MaxCount`),
  `Comment`       = VALUES(`Comment`);

-- =========================================================
-- 9. BOSS LOOT — TBC dungeon final bosses
-- =========================================================
INSERT INTO `creature_loot_template`
  (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`,
   `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT DISTINCT
  ie.`creditEntry`,
  @TBC_DUTY_ITEM,
  0,        -- Reference
  100,      -- Chance
  1,        -- QuestRequired
  1,        -- LootMode
  0,        -- GroupId
  1,        -- MinCount
  1,        -- MaxCount
  'Grim TBC duty mark'
FROM `instance_encounters` ie
JOIN `creature_template` ct ON ct.`entry` = ie.`creditEntry`
WHERE ie.`lastEncounterDungeon` != 0
  AND ie.`creditType` = 0
  AND ct.`exp` = 1
  AND ie.`lastEncounterDungeon` NOT IN (175,176,177,193,194,195,196,197,198,199,201)
ON DUPLICATE KEY UPDATE
  `Chance`        = VALUES(`Chance`),
  `QuestRequired` = VALUES(`QuestRequired`),
  `LootMode`      = VALUES(`LootMode`),
  `GroupId`       = VALUES(`GroupId`),
  `MinCount`      = VALUES(`MinCount`),
  `MaxCount`      = VALUES(`MaxCount`),
  `Comment`       = VALUES(`Comment`);

-- =========================================================
-- 10. QUEST DIALOG — request items (incomplete-quest NPC text)
-- =========================================================
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`) VALUES
  (@QUEST_CLASSIC,
   0, 0,
   'Have you recovered the Dungeon Duty Mark? The realm waits for no one — venture into a classic dungeon and defeat the final boss.'),
  (@QUEST_TBC,
   0, 0,
   'Have you obtained the Faction Service Mark? The forces of Outland are counting on you — clear a dungeon and bring proof of your victory.')
ON DUPLICATE KEY UPDATE
  `CompletionText` = VALUES(`CompletionText`);

-- =========================================================
-- 11. QUEST DIALOG — offer reward (turn-in NPC text)
-- =========================================================
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`) VALUES
  (@QUEST_CLASSIC,
   21, 0, 0, 0, 0, 0, 0, 0,
   'Well done, champion. The mark you carry proves your courage in the depths of Azeroth''s dungeons.$B$BAccept this Grim Token as a reward for your service. Return tomorrow — there are always more threats to face.'),
  (@QUEST_TBC,
   21, 0, 0, 0, 0, 0, 0, 0,
   'You''ve served your faction well beyond the Dark Portal. The dangers of Outland are not to be taken lightly, and yet you return victorious.$B$BTake this token as recognition of your efforts. The Envoy will have more work for you tomorrow.')
ON DUPLICATE KEY UPDATE
  `Emote1`     = VALUES(`Emote1`),
  `RewardText` = VALUES(`RewardText`);
