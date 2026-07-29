#
# This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by the
# Free Software Foundation; either version 3 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

# AzerothCore discovers module C++ sources from modules/ itself and generates
# the static loader from the directory name. Keep this file limited to assets
# that the core cannot auto-discover, so it works on the Playerbot branch too.
file(GLOB MOD_GRIMTOKENDAILIES_CONF_FILES "${CMAKE_CURRENT_LIST_DIR}/conf/*.conf.dist")
foreach(MOD_GRIMTOKENDAILIES_CONF_FILE ${MOD_GRIMTOKENDAILIES_CONF_FILES})
  install(FILES "${MOD_GRIMTOKENDAILIES_CONF_FILE}" DESTINATION "etc/modules")
endforeach()
