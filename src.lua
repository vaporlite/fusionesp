--[[

    fusion esp (chams only for now)
    made by fusion#8288
    v. 1.0

]]

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local cg = game:GetService("CoreGui")
local mouse = lp:GetMouse()

shared["toggled"] = false
shared["refresh"] = true

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

mouse.KeyDown:Connect(function(k)
    k = k:lower()
    if k == "p" then
        for _, player in next, plrs:GetPlayers() do
            if player == lp then
                continue
            end
            local before = cg:FindFirstChild(player.Name)
            if not before then
                AddEsp(player)
            end
        end
    end
end)
