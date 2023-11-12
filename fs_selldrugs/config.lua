Config = {}

Config.Locale       = "pl"

Config.Drugs = { 

    ["weed_baggy"] = {
        label = "Sell a Bag of Weed",
        icon = "fa-solid fa-cannabis",
        price = { min = 20, max = 70}, -- Sale price
        quantity  = { min = 3, max = 8}, -- possible number of sales at once
    },

    ["cocaine_pooch"] = {
        label = "Sell ​​Cocaine",
        icon = "fa-solid fa-prescription-bottle",
        price = { min = 20, max = 70}, -- Sale price
        quantity  = { min = 3, max = 8}, -- possible number of sales at once
    },

    ["hash"] = {
        label = "Sell Hash",
        icon = "fa-solid fa-cannabis",
        price = { min = 20, max = 70}, -- Sale price
        quantity  = { min = 3, max = 8}, -- possible number of sales at once
    },

    ["meth_pooch"] = {
        label = "Sell Methamphetamine",
        icon = "fa-solid fa-pills",
        price = { min = 20, max = 70}, -- Sale price
        quantity  = { min = 3, max = 8}, -- possible number of sales at once
    },

    ["amfetamina_pooch"] = {
        label = "Sell ​​Amphetamine",
        icon = "fa-solid fa-pills",
        price = { min = 20, max = 70}, -- Sale price
        quantity  = { min = 3, max = 8}, -- possible number of sales at once
    },
}

Config.MinPolice = 0 

SendDispatch = function() 
    local coords = GetEntityCoords(PlayerPedId())

end

Config.DisableNPCs = { -- peds on which there is no option to sell 
    ["example"] = true,
}