/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MOD_GRIMTOKENDAILIES_H
#define MOD_GRIMTOKENDAILIES_H

#include <cstdint>

struct GrimTokenDailiesConfig
{
    bool     Enabled              = true;
    bool     AnnounceOnLogin      = true;

    // Item entries (must match the SQL base data)
    uint32_t TokenItemId          = 90000;
    uint32_t ClassicDutyItemId    = 90001;
    uint32_t TbcDutyItemId        = 90002;

    // Quest entries
    uint32_t QuestClassicId       = 210010;
    uint32_t QuestTbcId           = 210011;

    // NPC entries
    uint32_t NpcAllianceEntry     = 900100;
    uint32_t NpcHordeEntry        = 900101;

    // Token reward amounts
    uint32_t ClassicTokenReward   = 1;
    uint32_t TbcTokenReward       = 2;
    uint32_t HeroicTokenReward    = 5;
};

extern GrimTokenDailiesConfig sGrimTokenDailies;

#endif // MOD_GRIMTOKENDAILIES_H
