--updates to the tech tree

-- make atom bomb prereq the science pack - remove kovarex prereq - add science pack as unit to atom bomb
local atomTech = data.raw.technology["atomic-bomb"]
if atomTech and atomTech.unit and atomTech.unit.ingredients and atomTech.prerequisites then
    leighzermods.utils.removePrerequisite("atomic-bomb","kovarex-enrichment-process")
    table.insert(atomTech.unit.ingredients,{leighzermods.leighzernuclearsciencepack.sciencePackName,1})
    table.insert(atomTech.prerequisites,leighzermods.leighzernuclearsciencepack.sciencePackName)
end

-- add tech as prereq to uranium ammo - add science pack as unit to uranium ammo
local uraniumAmmoTech = data.raw.technology["uranium-ammo"]
if uraniumAmmoTech and uraniumAmmoTech.unit and uraniumAmmoTech.unit.ingredients and uraniumAmmoTech.prerequisites then
    table.insert(uraniumAmmoTech.unit.ingredients,{leighzermods.leighzernuclearsciencepack.sciencePackName,1})
    table.insert(uraniumAmmoTech.prerequisites,leighzermods.leighzernuclearsciencepack.sciencePackName)
end

-- add tech as prereq to rocket - add science pack as unit to rocket tech
local rocketSiloTech = data.raw.technology["rocket-silo"]
if rocketSiloTech and rocketSiloTech.unit and rocketSiloTech.unit.ingredients and rocketSiloTech.prerequisites then
    table.insert(rocketSiloTech.unit.ingredients,{leighzermods.leighzernuclearsciencepack.sciencePackName,1})
    table.insert(rocketSiloTech.prerequisites,leighzermods.leighzernuclearsciencepack.sciencePackName)
end

-- add science pack to space science pack unit
local spaceSciencePackTech = data.raw.technology["space-science-pack"]
if spaceSciencePackTech and spaceSciencePackTech.unit and spaceSciencePackTech.unit.ingredients then
    table.insert(spaceSciencePackTech.unit.ingredients,{leighzermods.leighzernuclearsciencepack.sciencePackName,1})
end

-- add uranium science pack to all techs that have space science as part of their research
for k,v in pairs(data.raw.technology) do
    if v and v.unit and v.unit.ingredients then
        for i,vv in ipairs(v.unit.ingredients) do
            if vv[1] and vv[1] == "space-science-pack" then
                table.insert(v.unit.ingredients,{leighzermods.leighzernuclearsciencepack.sciencePackName,1})
                break
            end
        end
    end
end