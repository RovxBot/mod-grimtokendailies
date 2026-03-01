# mod-GrimTokenDailies

An [AzerothCore](https://www.azerothcore.org/) module that adds a **Grim Token** daily-dungeon quest system. Players pick up daily quests from faction-themed NPCs in Stormwind and Orgrimmar, run dungeons via the Dungeon Finder, loot a proof item from the final boss, and turn it in for Grim Tokens.

## What It Does

| Bracket | Quest | Required Drop | Token Reward |
|---------|-------|---------------|-------------|
| Classic dungeons (level 15+) | *Doing Your Duty* | Dungeon Duty Mark | 1 Grim Token |
| TBC dungeons (level 61+) | *Service to Your Faction* | Faction Service Mark | 2 Grim Tokens |
| WotLK Heroic Proof-of-Demise | *(existing quests)* | *(unchanged)* | 5 Grim Tokens |

### Items

| Entry | Name | Description |
|-------|------|-------------|
| 90000 | Grim Token | Currency token, stackable to 1000 |
| 90001 | Dungeon Duty Mark | Quest drop from Classic dungeon final bosses |
| 90002 | Faction Service Mark | Quest drop from TBC dungeon final bosses |

### NPCs

Two **Grim Token Envoy** NPCs are spawned (cloned from the local faction guard model):

- **Alliance** – Stormwind (entry 900100)
- **Horde** – Orgrimmar (entry 900101)

Both NPCs are quest givers for the Classic and TBC daily quests.

### Boss Loot

The module's SQL automatically wires duty-mark drops onto every dungeon final boss listed in `instance_encounters` (filtered by expansion and excluding raid encounters).

## Installation

1. Clone into your AzerothCore `modules/` directory:

   ```bash
   cd <azerothcore-source>/modules
   git clone https://github.com/<your-username>/mod-GrimTokenDailies.git
   ```

2. Re-run CMake and rebuild the server.

3. Copy `conf/mod_grimtokendailies.conf.dist` to your server's config directory and rename it to `mod_grimtokendailies.conf`. Adjust settings as desired.

4. The SQL files in `sql/world/base/` are applied automatically by the AzerothCore module loader on first start. If you prefer to apply them manually:

   ```
   sql/world/base/grimtokendailies_world.sql  →  acore_world
   ```

5. Restart the worldserver.

## Configuration

All settings live in `mod_grimtokendailies.conf` under the `[worldserver]` section.

| Setting | Default | Description |
|---------|---------|-------------|
| `ModGrimTokenDailies.Enable` | `1` | Master enable/disable |
| `ModGrimTokenDailies.Announce.Enable` | `1` | Announce module on player login |
| `ModGrimTokenDailies.TokenItemId` | `90000` | Item entry for Grim Token |
| `ModGrimTokenDailies.ClassicDutyItemId` | `90001` | Item entry for Classic duty mark |
| `ModGrimTokenDailies.TbcDutyItemId` | `90002` | Item entry for TBC duty mark |
| `ModGrimTokenDailies.QuestClassicId` | `210010` | Quest entry for Classic daily |
| `ModGrimTokenDailies.QuestTbcId` | `210011` | Quest entry for TBC daily |
| `ModGrimTokenDailies.NpcAllianceEntry` | `900100` | Alliance questgiver creature entry |
| `ModGrimTokenDailies.NpcHordeEntry` | `900101` | Horde questgiver creature entry |
| `ModGrimTokenDailies.ClassicTokenReward` | `1` | Tokens for Classic daily |
| `ModGrimTokenDailies.TbcTokenReward` | `2` | Tokens for TBC daily |
| `ModGrimTokenDailies.HeroicTokenReward` | `5` | Tokens for WotLK Heroic Proof-of-Demise |

> **Note:** Changing item/quest/NPC entry IDs in the config has no effect unless you also update the corresponding SQL. The config values are exposed for C++ runtime reference only.

## Excluded Raid Encounters

The loot SQL excludes these `lastEncounterDungeon` IDs so raid bosses do **not** drop duty marks:

- **Classic raids:** 42, 48, 50, 160, 161
- **TBC raids:** 175, 176, 177, 193–199, 201

## Requirements

- [AzerothCore](https://www.azerothcore.org/) with the latest master branch

## License

This module is released under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html).
