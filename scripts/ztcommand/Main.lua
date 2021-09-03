-- Include Zoo Tycoon 2 libraries
include "scenario/scripts/entity.lua"
include "scenario/scripts/token.lua"
include "scenario/scripts/ui.lua"
include "scenario/scripts/misc.lua"

-- Include ArluqTools
include "scripts/ArluqTools/lua/try.lua"
include "scripts/ArluqTools/services/AnimalService.lua"

-- Include Command Managers
include "scripts/ztcommand/commands/AnimalCommands.lua"


function Main(args)
    try(
        function()
            -- Game Manager
            local gameMgr = queryObject("BFGManager")
            if gameMgr == nil then
                return error("BFGManager not found")
            end

            -- Animals
            local animalList = findType("animal")
            if animalList == nil or type(animalList) ~= "table" then
                return error("No animals found")
            end
            AnimalCommands(animalList)
        end
    )
end