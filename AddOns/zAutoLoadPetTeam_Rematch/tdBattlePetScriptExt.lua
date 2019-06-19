tdBattlePetScript:RegisterCondition('count', { type = 'compare', arg = false }, function(owner, pet)
    return C_PetBattles.GetNumPets(owner)
end)

tdBattlePetScript:RegisterCondition('hp.explode', { type = 'boolean', arg = false }, function(owner, pet)

    local player , enemy
    if owner == LE_BATTLE_PET_ENEMY then 
        player = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)
        enemy = pet
    else
        player = pet
        enemy =  C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)
    end
    return C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, enemy) < floor(C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, player) * 0.4)

end)