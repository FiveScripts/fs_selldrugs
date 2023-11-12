-- * FRAMEWORK * --

ESX = exports.es_extended:getSharedObject()



-- * FUNCTIONS * --

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function PedIsBlacklisted(model)
    for l, v in pairs(Config.DisableNPCs) do
        if GetHashKey(l) == model then
            return true
        end
    end
    return false
end

-- * MAIN * --

CreateThread(function()
    for l, v in pairs(Config.Drugs) do
        exports.ox_target:addGlobalPed({
            {
                name = 'sprzedajdragi' .. l,
                icon = v.icon,
                label = v.label,
                items = l,
                canInteract = function(entity, distance, coords, name)
                    local PlayerData = ESX.GetPlayerData()
                    if PedIsBlacklisted(GetEntityModel(entity)) or IsEntityPositionFrozen(entity) or PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" then return false else return true end
                end,
                onSelect = function(data)
                    local Ped = data.entity

                    ESX.TriggerServerCallback("fs_selldrugs:checkPolice", function(polices)
                        if polices >= Config.MinPolice then
                            ESX.TriggerServerCallback("fs_selldrugs:checkDrugQuantity", function(haveMinQuantity)
                                if haveMinQuantity then 
                                    FreezeEntityPosition(Ped, true)
                                    loadAnimDict("amb@world_human_prostitute@cokehead@base")
                                    TaskPlayAnim(Ped, "amb@world_human_prostitute@cokehead@base", "base", 8.0, -8.0, -1, 49, 0, false,
                                        false, false)
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    loadAnimDict("gestures@m@standing@casual")
                                    TaskPlayAnim(PlayerPedId(), "gestures@m@standing@casual", "gesture_easy_now", 8.0, -8.0, -1, 0, 0,
                                        false, false, false)
                                    if lib.progressCircle({
                                            duration = 15000,
                                            position = 'bottom',
                                            useWhileDead = false,
                                            canCancel = true,
                                            disable = {
                                                car = true,
                                            },
                                        }) then
                                        local szansa = math.random(0, 100)
                                        if szansa >= 20 then
                                            loadAnimDict('mp_common')
                                            TaskPlayAnim(Ped, "mp_common", "givetake1_a", 8.0, 8.0, 2000, 50, 0, false, false,
                                                false)
                                            TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, 8.0, 2000, 50, 0,
                                                false, false, false)
                                            Citizen.Wait(1000)
                                            ESX.ShowNotification(_U('offer_accepted'))
                                            TriggerServerEvent("fs_selldrugs:SellDrug", l)
                                            FreezeEntityPosition(PlayerPedId(), false)
                                            ClearPedTasks(PlayerPedId())
                                            FreezeEntityPosition(Ped, false)
                                            ClearPedTasks(Ped)
                                        else
                                            SendDispatch()
                                            FreezeEntityPosition(PlayerPedId(), false)
                                            ClearPedTasks(PlayerPedId())
                                            FreezeEntityPosition(Ped, false)
                                            ClearPedTasks(Ped)
                                            ESX.ShowNotification(_U('offer_rejected'))
                                        end
                                    else
                                        FreezeEntityPosition(PlayerPedId(), false)
                                        ClearPedTasks(PlayerPedId())
                                        FreezeEntityPosition(Ped, false)
                                        ClearPedTasks(Ped)
                                        ESX.ShowNotification(_U('canceled'))
                                    end
                                else
                                    
                                    ESX.ShowNotification("Nie posiadasz wystarczajacej liczby " .. l)
                                end

                            end, l)
                        else
                            ESX.ShowNotification(_U('nopolice'))
                        end
                    end)
                end
            },
        })
    end
end)