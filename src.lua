--[[

    fusion esp (chams only for now)
    made by fusion#8288
    v. 1.0

]]

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local cg = game:GetService("CoreGui")
local uis = game:GetService("UserInputService")

shared["toggled"] = false
shared["refresh"] = true

local function isFriend(id)
    for _, pl in pairs(plrs:GetPlayers()) do
        if lp:IsFriendsWith(id) then
            return true
        end
    end
    return false
end 

local function AddEsp(p)
    local highlight = Instance.new("Highlight")
    highlight.Parent = cg
    highlight.Adornee = p.Character
    highlight.Name = p.Name
    highlight.OutlineTransparency = 0
    if p.Team then
        highlight.FillColor = p.TeamColor.Color
        highlight.OutlineColor = p.TeamColor.Color
    else
        highlight.FillColor = Color3.fromRGB(170, 63, 232)
        highlight.OutlineColor = Color3.fromRGB(170, 63, 232)
    end
    if isFriend(p.UserId) then
        highlight.FillColor = Color3.fromRGB(61, 252, 3)
        highlight.OutlineColor = Color3.fromRGB(61, 252, 3)
    end

    p.CharacterAdded:Connect(function(c)
        local before = cg:FindFirstChild(p.Name)
        if before then
            before.Adornee = c
            if p.Team then
                before.FillColor = p.TeamColor.Color
                highlight.OutlineColor = p.TeamColor.Color
            else
                before.FillColor = Color3.fromRGB(170, 63, 232)
                highlight.OutlineColor = Color3.fromRGB(170, 63, 232)
            end
            if isFriend(p.UserId) then
                highlight.FillColor = Color3.fromRGB(61, 252, 3)
                highlight.OutlineColor = Color3.fromRGB(61, 252, 3)
            end
        end
    end)
    plrs.PlayerRemoving:Connect(function(p)
        local before = cg:FindFirstChild(p.Name)
        if before then
            before:Destroy()
        end
    end)
end

plrs.PlayerAdded:Connect(AddEsp)

for _, player in next, plrs:GetPlayers() do
    if player == lp then
        continue
    end
    AddEsp(player)
end

--[[uis.InputBegan:Connect(function(i,gpe)
    if gpe then return end
    if i.KeyCode == Enum.KeyCode.F5 then
        print('[FusionESP] refreshing...')
        for _, player in next, plrs:GetPlayers() do
            if player == lp then
                continue
            end
            local before = cg:FindFirstChild(player.Name)
            if not before then
                AddEsp(player)
                print('[FusionESP] refreshed '..player.Name..' (added esp to him)')
            else
                before.Adornee = player.Character
                if isFriend(p) then
                    before.FillColor = Color3.fromRGB(61, 252, 3)
                    before.OutlineColor = Color3.fromRGB(61, 252, 3)
                end
                print('[FusionESP] refreshed '..player.Name..' (had esp object before)')
            end
        end
    end
end)]]

local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/lua-releases/main/uis/boxlib.lua"))()

local win = SolarisLib:New({
    Name = "⚙️ FusionESP",
    FolderToSave = "fusionesp"
})

local settings_tab = win:Tab("Settings")

local settings_enemies = settings_tab:Section("Enemies")



local settings_keybinds = settings_tab:Section("Keybinds")

settings_keybinds:Bind("Refresh", Enum.KeyCode.F5, false, "refreshbind", function()
    print('[FusionESP] refreshing...')
    for _, player in next, plrs:GetPlayers() do
        if player == lp then
            continue
        end
        local before = cg:FindFirstChild(player.Name)
        if not before then
            AddEsp(player)
            print('[FusionESP] refreshed '..player.Name..' (added esp to him)')
        else
            before.Adornee = player.Character
            if isFriend(player.UserId) then
                before.FillColor = Color3.fromRGB(61, 252, 3)
                before.OutlineColor = Color3.fromRGB(61, 252, 3)
            end
            print('[FusionESP] refreshed '..player.Name..' (had esp object before)')
        end
    end
end)
