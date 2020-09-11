--require('__debugadapter__/debugadapter.lua')

if not leighzermods then --generic mod variable to store information that may be needed later
    leighzermods = {}
end

if not leighzermods.leighzernuclearsciencepack then
    leighzermods.leighzernuclearsciencepack = {}

    leighzermods.leighzernuclearsciencepack.energyRequired = 21
    leighzermods.leighzernuclearsciencepack.resultCount = 3    
    leighzermods.leighzernuclearsciencepack.subgroup = "science-pack"
    leighzermods.leighzernuclearsciencepack.order = "f[utility-science-pack]-a" -- order immediately after utility science pack

end

-- create science pack item
local sciencePackName = "nuclear-science-pack"
local sciencePackTool = {
    type = "tool",
    name = sciencePackName,
    localised_name = "Nuclear science pack",
    icon = "__leighzernuclearsciencepack__/graphics/icons/nuclear-science-pack.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = leighzermods.leighzernuclearsciencepack.subgroup,
    order = leighzermods.leighzernuclearsciencepack.order,
    stack_size = 200,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",

    leighzerscienceoresOreTintName = "lime",
    leighzerscienceoresStartingAreaEnabled = false
}
data:extend({
    sciencePackTool
})

-- create science pack recipe
local sciencePackIngredients = {
    {"heat-exchanger",1},
    {"steam-turbine",1},
    {"uranium-fuel-cell",1}
}
leighzermods.utils.createRecipe(sciencePackName,leighzermods.leighzernuclearsciencepack.energyRequired, false, "crafting",sciencePackIngredients,sciencePackName,leighzermods.leighzernuclearsciencepack.resultCount,leighzermods.leighzernuclearsciencepack.subgroup,leighzermods.leighzernuclearsciencepack.order,true)

-- create science pack technology
-- add kovarex processing to technology prereq
local sciencePackTechIcons = {{icon="__leighzernuclearsciencepack__/graphics/technology/nuclear-science-pack.png",icon_size=128}}
local sciencePackTechEffects = {{type="unlock-recipe",recipe=sciencePackName}}
local sciencePackTechUnit = {
    count = 1500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 30
}
local sciencePackTechPrereqs = {"kovarex-enrichment-process"}
leighzermods.utils.createTechnology(sciencePackName,sciencePackTechIcons,true,sciencePackTechEffects,sciencePackTechUnit,sciencePackTechPrereqs,"c-b","Nuclear science pack","Allows research of powerful uranium weaponry, and proper spaceflight.")

-- make atom bomb prereq the science pack - remove kovarex prereq - add science pack as unit to atom bomb
local atomTech = data.raw.technology["atomic-bomb"]
if atomTech and atomTech.unit and atomTech.unit.ingredients and atomTech.prerequisites then
    leighzermods.utils.removePrerequisite("atomic-bomb","kovarex-enrichment-process")
    table.insert(atomTech.unit.ingredients,{sciencePackName,1})
    table.insert(atomTech.prerequisites,sciencePackName)
end

-- add tech as prereq to uranium ammo - add science pack as unit to uranium ammo
local uraniumAmmoTech = data.raw.technology["uranium-ammo"]
if uraniumAmmoTech and uraniumAmmoTech.unit and uraniumAmmoTech.unit.ingredients and uraniumAmmoTech.prerequisites then
    table.insert(uraniumAmmoTech.unit.ingredients,{sciencePackName,1})
    table.insert(uraniumAmmoTech.prerequisites,sciencePackName)
end

-- add tech as prereq to rocket - add science pack as unit to rocket tech
local rocketSiloTech = data.raw.technology["rocket-silo"]
if rocketSiloTech and rocketSiloTech.unit and rocketSiloTech.unit.ingredients and rocketSiloTech.prerequisites then
    table.insert(rocketSiloTech.unit.ingredients,{sciencePackName,1})
    table.insert(rocketSiloTech.prerequisites,sciencePackName)
end

-- add science pack to space science pack unit
local spaceSciencePackTech = data.raw.technology["space-science-pack"]
if spaceSciencePackTech and spaceSciencePackTech.unit and spaceSciencePackTech.unit.ingredients then
    table.insert(spaceSciencePackTech.unit.ingredients,{sciencePackName,1})
end

-- add uranium science pack to all techs that have space science as part of their research
for k,v in pairs(data.raw.technology) do
    if v and v.unit and v.unit.ingredients then
        for i,vv in ipairs(v.unit.ingredients) do
            if vv[1] and vv[1] == "space-science-pack" then
                table.insert(v.unit.ingredients,{sciencePackName,1})
                break
            end
        end
    end
end