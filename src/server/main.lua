-- //[Variables]\\ --
Core = { 
    ESX = { Installed = false },
    Cache = { Players = {}, Entities = {} },
    Classes = {},
    Functions = {},
    http = {}
}
---@Core
---@Comment ESX Instance
---@Core.ESX
---@Comment Cache for global cache and cache system
---@Core.Cache
---@Comment Classes for creating classes
---@Core.Classes
---@Comment Functions for creating global functions
---@Core.Functions
---@Comment HTTP for creating http requests
---@Core.http


-- //[Load ESX]\\ --
Core.Functions:TryCatch(function()
    ESX = exports["es_extended"]:getSharedObject()
    Core.ESX = ESX
    Core.ESX.Installed = true
    debug("[ESX] ESX Loaded.")
end, function(error)
    print("error", "[ESX] Failed to load ESX.")
end)

-- //[Player Handler]\\ --
RegisterNetEvent("playerJoining", function(source)
    if not source then return end

    Core.Functions:TryCatch(function()
        if Core.Cache.Players[source] then
            print("warn", "[playerJoining Handler] Player already exists: " .. source)
        end
        Core.Cache.Players[source] = Core.Classes:createUser(source)
        debug("[playerCreated Handler] Player created: " .. source)
    end, function(error)
        print("error", "[playerCreated Handler] Error: " .. error)
    end)
end)

RegisterNetEvent("playerDropped", function()
    if not source then return end

    Core.Functions:TryCatch(function()
        Core.Cache.Players[source] = nil
        debug("[playerDropped Handler] Player dropped: " .. source)
    end, function(error)
        print("error", "[playerDropped Handler] Error: " .. error)
    end)
end)

-- //[Entity Handler]\\ --
RegisterNetEvent("--CreatedEntitue--", function(entity)
    if not DoesEntityExist(entity) then return end
    local netId = NetworkGetNetworkIdFromEntity(entity)

    Core.Functions:TryCatch(function()
        if Core.Cache.Entities[netId] then
            print("warn", "[Entity Handler] Entity already exists: " .. netId)
        end
        Core.Cache.Entities[netId] = Core.Classes:createEntity(entity)
        debug("[Entity Handler] Entity created: " .. netId)
    end, function(error)
        print("error", "[Entity Handler] Error: " .. error)
    end)
end)

