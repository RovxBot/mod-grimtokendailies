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

#include "mod_grimtokendailies.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "Log.h"

// Global config instance
GrimTokenDailiesConfig sGrimTokenDailies;

// -------------------------------------------------------
// WorldScript — load configuration on server start / reload
// -------------------------------------------------------
class GrimTokenDailies_WorldScript : public WorldScript
{
public:
    GrimTokenDailies_WorldScript() : WorldScript("GrimTokenDailies_WorldScript") {}

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sGrimTokenDailies.Enabled            = sConfigMgr->GetOption<bool>("ModGrimTokenDailies.Enable", true);
        sGrimTokenDailies.AnnounceOnLogin    = sConfigMgr->GetOption<bool>("ModGrimTokenDailies.Announce.Enable", true);

        sGrimTokenDailies.TokenItemId        = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.TokenItemId", 90000);
        sGrimTokenDailies.ClassicDutyItemId  = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.ClassicDutyItemId", 90001);
        sGrimTokenDailies.TbcDutyItemId      = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.TbcDutyItemId", 90002);

        sGrimTokenDailies.QuestClassicId     = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.QuestClassicId", 210010);
        sGrimTokenDailies.QuestTbcId         = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.QuestTbcId", 210011);

        sGrimTokenDailies.NpcAllianceEntry   = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.NpcAllianceEntry", 900100);
        sGrimTokenDailies.NpcHordeEntry      = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.NpcHordeEntry", 900101);

        sGrimTokenDailies.ClassicTokenReward = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.ClassicTokenReward", 1);
        sGrimTokenDailies.TbcTokenReward     = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.TbcTokenReward", 2);
        sGrimTokenDailies.HeroicTokenReward  = sConfigMgr->GetOption<uint32>("ModGrimTokenDailies.HeroicTokenReward", 5);

        LOG_INFO("server.loading", ">> Loaded mod-GrimTokenDailies configuration (enabled={})", sGrimTokenDailies.Enabled);
    }
};

// -------------------------------------------------------
// PlayerScript — login announcement
// -------------------------------------------------------
class GrimTokenDailies_PlayerScript : public PlayerScript
{
public:
    GrimTokenDailies_PlayerScript() : PlayerScript("GrimTokenDailies_PlayerScript") {}

    void OnLogin(Player* player) override
    {
        if (!sGrimTokenDailies.Enabled || !sGrimTokenDailies.AnnounceOnLogin)
            return;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "|cff4CFF00[Grim Token Dailies]|r Visit the Grim Token Envoy in Stormwind or Orgrimmar for daily dungeon quests!");
    }
};

// -------------------------------------------------------
// Registration
// -------------------------------------------------------
void AddModGrimTokenDailiesScripts()
{
    new GrimTokenDailies_WorldScript();
    new GrimTokenDailies_PlayerScript();
}
