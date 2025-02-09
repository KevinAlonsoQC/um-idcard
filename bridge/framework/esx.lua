if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports['es_extended']:getSharedObject()

local metadata = {}

--- Create metadata for license
---@param src number Source number
---@param itemTable string | table Item name or table of item names
local function CreateMetaLicense(src, itemTable)
    local xPlayer = ESX.GetPlayerFromId(src)

    if type(itemTable) == "string" then
        itemTable = {itemTable}
    end

    if type(itemTable) == "table" then
        for _, v in pairs(itemTable) do
            metadata = {
                cardtype = v,
                identifier = xPlayer.getIdentifier(),
                firstName = xPlayer.variables.firstName,
                lastName = xPlayer.variables.lastName,
                dob = xPlayer.variables.dateofbirth,
                sex =  xPlayer.variables.sex,
                nationality = 'Los Santos',
                mugShot = 'none',
            }
            exports.ox_inventory:AddItem(src, v, 1, metadata)
        end
    else
        print("Invalid parameter type")
    end
end

exports('CreateMetaLicense', CreateMetaLicense)


--- Create metadata for license
---@param k string item name
function CreateRegisterItem(k)
    ESX.RegisterUsableItem(k, function(source, _, item)
        TriggerEvent('um-idcard:server:sendData', source, item.metadata)
    end)
end


