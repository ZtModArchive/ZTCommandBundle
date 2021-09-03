function AnimalCommands (animalList)
    -- Loop over each animal
    local numAnimal = table.getn(animalList)
    for i = 1, numAnimal, 1 do
        local animal = resolveTable(animalList[i].value)
        if animal == nil then
            return error("Animal not found")
        end

        local name = animal:BFG_GET_ATTR_STRING("s_name")
        if string.sub(name, 1, 3) == "ztc" then

            -- change the animal name to prevent relooping
            local species = animal:BFG_GET_ATTR_STRING("s_Species")
            animal:BFG_SET_ATTR_STRING("s_name", species)

            if string.find(name, "age=") then
                local age = "Adult"
                if string.find(name, "age=young") then
                    age = "Young"
                end
                AnimalService.setAge(animal, age)

            elseif string.find(name, "gender=") then
                local gender = "F"
                if string.find(name, "gender=male") then
                    gender = "M"
                end
                AnimalService.setGender(animal, gender)
            
            elseif string.find(name, "pregnant=") then
                local isPregnant = false
                if string.find(name, "pregnant=true") then
                    isPregnant = true
                end
                AnimalService.setPregnant(animal, isPregnant)

            elseif string.find(name, "random") then
                local randomAnimalType = getRandomAnimalType()
                local species = getSpeciesFromType(randomAnimalType)
                AnimalService.setSpecies(animal, species)

            elseif string.find(name, "super=") then
                local isSuper = false
                if string.find(name, "super=true") then
                    isSuper = true
                end
                AnimalService.setSuper(animal, isSuper)

            end
        end
    end
end