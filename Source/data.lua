if not leighzermods then --generic mod variable to store information that may be needed later
    leighzermods = {}
end

if not leighzermods.leighzernuclearsciencepack then
    leighzermods.leighzernuclearsciencepack = {}

    leighzermods.leighzernuclearsciencepack.energyRequired = 21
    leighzermods.leighzernuclearsciencepack.resultCount = 3    
    leighzermods.leighzernuclearsciencepack.subgroup = "science-pack"
    leighzermods.leighzernuclearsciencepack.order = "f[utility-science-pack]-a" -- order immediately after utility science pack
    leighzermods.leighzernuclearsciencepack.sciencePackName = "nuclear-science-pack"

end

-- create science pack item
local sciencePackTool = {
    type = "tool",
    name = leighzermods.leighzernuclearsciencepack.sciencePackName,
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
    leighzerscienceoresStartingAreaEnabled = false,

    leighzerburiedscienceMapTintName = "lime",
    leighzerburiedscienceStartingAreaEnabled = false,
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
leighzermods.utils.createRecipe(leighzermods.leighzernuclearsciencepack.sciencePackName,leighzermods.leighzernuclearsciencepack.energyRequired, false, "crafting",sciencePackIngredients,leighzermods.leighzernuclearsciencepack.sciencePackName,leighzermods.leighzernuclearsciencepack.resultCount,leighzermods.leighzernuclearsciencepack.subgroup,leighzermods.leighzernuclearsciencepack.order,true)

-- create science pack technology
-- add kovarex processing to technology prereq
local sciencePackTechIcons = {{icon="__leighzernuclearsciencepack__/graphics/technology/nuclear-science-pack.png",icon_size=128}}
local sciencePackTechEffects = {{type="unlock-recipe",recipe=leighzermods.leighzernuclearsciencepack.sciencePackName}}
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
leighzermods.utils.createTechnology(leighzermods.leighzernuclearsciencepack.sciencePackName,sciencePackTechIcons,true,sciencePackTechEffects,sciencePackTechUnit,sciencePackTechPrereqs,"c-b","Nuclear science pack","Allows research of powerful uranium weaponry and proper spaceflight.")