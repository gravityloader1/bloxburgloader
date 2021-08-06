local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local CurrentVersion = "1.0.0"

function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local AuthorizationBase64String = enc("gravityscriptsofficial@gmail.com:LSOX8VC86B6X7A51")

local Response = syn.request({
    Url = "https://GravityBot.gravityofficial.repl.co/checkauth/erlc/" .. game.Players.LocalPlayer.UserId,
    Method = "GET",
    Headers = {
        ["Content-Type"] = "text/plain",
        ["Authorization"] = "Basic " .. AuthorizationBase64String
    }
})


if not Response.Success then
    game.Players.LocalPlayer:Kick("\n[GRAVITY SCRIPTS]\nWe are terribly sorry, it seems our servers are currently down\nPlease inform a Developer+ about the issue and we will get it sorted instantly!\nSorry for any inconvenice caused by this.")
end

if Response.Body == "false" then
    game.Players.LocalPlayer:Kick("\n[GRAVITY SCRIPTS]\nYou are not whitelisted to use this script\nPlease make a ticket on our buyers server if you believe this is a mistake.")
elseif Response.Body == "true" then
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/GravityManager/gravity/main/bloxburgluna.lua"))()
end

end
