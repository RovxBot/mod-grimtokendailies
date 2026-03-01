# mod-GrimTokenDailies

An [AzerothCore](https://www.azerothcore.org/) module that adds custom quests, items, and NPCs to the game.

## Features

- Custom NPCs
- Custom quests (including dailies)
- Custom items / tokens

## Installation

1. Clone this repository into your AzerothCore `modules/` directory:

   ```bash
   cd <azerothcore-source>/modules
   git clone https://github.com/<your-username>/mod-GrimTokenDailies.git
   ```

2. Re-run CMake and rebuild the server.

3. Copy `conf/mod_grimtokendailies.conf.dist` to your server's config directory and rename it to `mod_grimtokendailies.conf`. Adjust settings as desired.

4. Apply the SQL files:
   - `sql/world/base/grimtokendailies_world.sql` → **world** database
   - `sql/characters/base/grimtokendailies_characters.sql` → **characters** database (if applicable)
   - `sql/auth/base/grimtokendailies_auth.sql` → **auth** database (if applicable)

5. Restart the worldserver.

## Configuration

| Setting | Default | Description |
|---|---|---|
| `ModGrimTokenDailies.Enable` | `1` | Enable or disable the module |
| `ModGrimTokenDailies.Announce.Enable` | `1` | Announce module on player login |

## Requirements

- [AzerothCore](https://www.azerothcore.org/) with the latest master branch

## License

This module is released under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html).
