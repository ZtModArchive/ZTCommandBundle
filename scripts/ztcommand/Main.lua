-- Include Zoo Tycoon 2 libraries
include "scenario/scripts/entity.lua"
include "scenario/scripts/token.lua"
include "scenario/scripts/ui.lua"
include "scenario/scripts/misc.lua"

-- Include tools script
include "scripts/tools/luaTools.lua"

-- Include command scripts
include "scripts/ztcommand/services/AnimalService.lua"

function Main(args)
    try(
        function()
            -- BFGManager
            local gameMgr = queryObject("BFGManager")
            if gameMgr == nil then
                return error("BFGManager not found")
            end

            -- Animals
            local animalList = findType("animal")
            if animalList == nil or type(animalList) ~= "table" then
                return error("No animals found")
            end
            
            -- Loop over each animal
            local numAnimal = table.getn(animalList)
            for i = 1, numAnimal, 1 do
                local animal = resolveTable(animalList[i].value)
                if animal == nil then
                    return error("Animal not found")
                end

                local name = animal:BFG_GET_ATTR_STRING("s_name")
                if string.sub(name, 1, 3) == "ztc" then

                    -- Execute commands
                    if string.find(name, "age=") then
                        local age = "Adult"
                        if string.find(name, "age=young") then
                            age = "Young"
                        end
                        setAge(animal, age)
                    end
                    
                    if string.find(name, "pregnant=") then
                        local isPregnant = false
                        if string.find(name, "pregnant=true") then
                            isPregnant = true
                        end
                        setPregnant(animal, isPregnant)
                    end

                    -- change the animal name to prevent relooping
                    local species = animal:BFG_GET_ATTR_STRING("s_Species")
                    animal:BFG_SET_ATTR_STRING("s_name", species)
                end
            end
        end
    )
end