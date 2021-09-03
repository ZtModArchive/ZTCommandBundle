-- Include Zoo Tycoon 2 libraries
include "scenario/scripts/entity.lua"
include "scenario/scripts/token.lua"
include "scenario/scripts/ui.lua"
include "scenario/scripts/misc.lua"

-- Include tools script
include "scripts/tools/luaTools.lua"

--- Get animal age as sting
--- @param animal animal
function getAgeString (animal)
    local isAdult = animal:BFG_GET_ATTR_BOOLEAN("b_Adult")
    if isAdult then
        return "Adult"
    end
    return "Young"
end

--- Get animal gender as sting
--- @param animal animal
function getGenderString (animal)
    local isMale = animal:BFG_GET_ATTR_BOOLEAN("b_Male")
    if isMale then
        return "M"
    end
    return "F"
end

--- Get animal super status as sting
--- @param animal animal
function getSuperString (animal)
    local isSuper = animal:BFG_GET_ATTR_BOOLEAN("b_Super")
    if isSuper then
        return "_Super"
    end
    return ""
end

--- Set animal age
--- @param animal animal
--- @param age string
function setAge (animal, age)
    local species = animal:BFG_GET_ATTR_STRING("s_Species")
    local gender = self.getGenderString(animal)
    local super = self.getSuperString(animal)

    animal:BFG_ENTITY_MORPH_TO_NEW_ENTITY(species .. "_" .. age .. "_" .. gender .. super, false, 0, false, 1)
end

--- Set animal gender
--- @param animal animal
--- @param gender string
function setGender (animal, gender)
    local species = animal:BFG_GET_ATTR_STRING("s_Species")
    local age = self.getAgeString(animal)
    local super = self.getSuperString(animal)

    animal:BFG_ENTITY_MORPH_TO_NEW_ENTITY(species .. "_" .. age .. "_" .. gender .. super, false, 0, false, 1)
end

--- Set animal pregnancy
--- @param animal animal
--- @param isPregnant bool
function setPregnant (animal, isPregnant)
    local isMale = animal:BFG_GET_ATTR_BOOLEAN("b_Male")

    if isPregnant then
        if (isMale == false) then
            local pregnantSeed = string.format("[[<BFAIToken Name=\"%s\" Force=\"%d\" Timeout=\"%.1f\" Timein=\"%.1f\" />]]", "t_Pregnant", 100, -1, 90)
            local pregnantSeedToken = loadComponent(pregnantSeed)
            animal:BFG_SEND_TOKEN(pregnantSeedToken)
            animal:BFG_SET_ATTR_BOOLEAN("b_Pregnant", true)
        end
    else
        animal:BFG_SET_ATTR_BOOLEAN("b_Pregnant", false)
    end
end

--- Set animal super status
--- @param animal animal
--- @param isSuper bool
function setSuper (animal, isSuper)
    local species = animal:BFG_GET_ATTR_STRING("s_Species")
    local age = self.getAgeString(animal)
    local gender = self.getGenderString(animal)

    if isSuper then
        animal:BFG_ENTITY_MORPH_TO_NEW_ENTITY(species .. "_" .. age .. "_" .. gender .. "_Super", false, 0, false, 1)
    else
        animal:BFG_ENTITY_MORPH_TO_NEW_ENTITY(species .. "_" .. age .. "_" .. gender, false, 0, false, 1)
    end
end

--- Set animal species
--- @param animal animal
--- @param setSpecies string
function setSpecies (animal, species)
    local gender = self.getGenderString(animal)
    local age = self.getAgeString(animal)
    local super = self.getSuperString(animal)

    animal:BFG_ENTITY_MORPH_TO_NEW_ENTITY(species .. "_" .. age .. "_" .. gender .. super, false, 0, false, 1)
end