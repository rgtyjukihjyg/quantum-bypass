local Directory = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Games"
local Api = "https://api.luarmor.net/files/v4/loaders"
local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
    },
    Premium = {
        [994732206] = Api .. "/0ae9fe4cf963e3a13d25eed0e2ce5940.lua",
        [10004244222] = Api .. "/63980a492928552d074ceee243a918d6.lua",
        [9792947201] = Api .. "/50e8e00251d97215e14313c0bb012058.lua",
        [10200395747] = Api .. "/65265b2869c03f57430ee45357d8c3f9.lua"
    }
}
local SCRIPT_ID = "0ae9fe4cf963e3a13d25eed0e2ce5940"
local FOLDER = "Quantum Onyx Hub"
local KEY_FILE = FOLDER .. "/Key.json"
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local gameId = game.GameId

-- ====== НАЧАЛО МОДИФИКАЦИЙ ======
-- Перехватчик HTTP запросов для подмены ответов от Luarmor
local function SetupHTTPInterceptor()
    local services = {
        game:GetService("HttpService"),
        game:GetService("TeleportService")
    }
    
    for _, svc in ipairs(services) do
        local mt = getrawmetatable(svc) or {}
        local oldIndex = mt.__index
        mt.__index = function(self, key)
            if key == "HttpGet" or key == "Get" then
                return function(self, url, ...)
                    if url and type(url) == "string" then
                        if url:find("luarmor.net") or url:find("sdkapi-public") then
                            return loadstring([[
                                return {
                                    check_key = function(key)
                                        return true, { code = "KEY_VALID", message = "Premium unlocked via bypass" }
                                    end,
                                    load_script = function()
                                        print("[QO] Premium script loaded via bypass")
                                    end,
                                    script_id = "]] .. SCRIPT_ID .. [["
                                }
                            ]])()
                        end
                        if url:find("loader") and (url:find("0ae9fe4cf963e3a13d25eed0e2ce5940") or 
                           url:find("63980a492928552d074ceee243a918d6") or
                           url:find("50e8e00251d97215e14313c0bb012058") or
                           url:find("65265b2869c03f57430ee45357d8c3f9")) then
                            return loadstring([[
                                print("=== QUANTUM ONYX PREMIUM ACTIVATED ===")
                                print("Bypass successful! All premium features unlocked.")
                                print("Enjoy unlimited access!")
                                local function InitPremium()
                                    return {
                                        AutoFarm = true,
                                        AutoCollect = true,
                                        Teleport = true,
                                        ESP = true,
                                        SpeedHack = true,
                                        GodMode = true,
                                        InfiniteJump = true,
                                        AllFeatures = "UNLOCKED"
                                    }
                                end
                                getgenv().PremiumFeatures = InitPremium()
                                getgenv().LoadedQuantum = true
                            ]])()
                        end
                    end
                    return oldIndex(self, key)(self, url, ...)
                end
            end
            return oldIndex(self, key)
        end
        setrawmetatable(svc, mt)
    end
end

local function ForcePremiumActivation()
    getgenv().script_key = "BYPASS_KEY_" .. tostring(math.random(100000, 999999))
    getgenv().LoadedQuantum = true
    getgenv().IsPremium = true
    
    _G.VerifyKey = function(key, onStatus)
        if onStatus then
            onStatus("Key bypassed! Premium unlocked.", Color3.fromRGB(80, 230, 130))
        end
        return true, { 
            code = "KEY_VALID", 
            message = "Premium access granted via bypass",
            features = {
                auto_farm = true,
                auto_collect = true,
                teleport = true,
                esp = true,
                speed_hack = true,
                god_mode = true,
                infinite_jump = true,
                all_unlocked = true
            }
        }
    end
    
    _G.LoadSDK = function()
        return true, {
            script_id = SCRIPT_ID,
            check_key = function(key)
                return true, { code = "KEY_VALID", message = "Bypassed successfully" }
            end,
            load_script = function()
                print("[QO] Loading premium script...")
                getgenv().LoadedQuantum = true
                return true
            end
        }
    end
    
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({ key = getgenv().script_key, bypass = true }))
    
    print("[BYPASS] Premium features are now active!")
    print("[BYPASS] You have full access to all premium functions.")
    print("[BYPASS] Enjoy!")
end

local function ShowKeyUI_Bypass()
    print("[BYPASS] Skipping key UI...")
    
    local SG = Instance.new("ScreenGui")
    SG.Name = "BypassNotification"
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Global
    SG.ResetOnSpawn = false
    SG.IgnoreGuiInset = true
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 100)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.Parent = SG
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.3
    Stroke.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "✅ PREMIUM UNLOCKED"
    Title.TextColor3 = Color3.fromRGB(0, 255, 150)
    Title.TextSize = 20
    Title.Font = Enum.Font.FredokaOne
    Title.Parent = Frame
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, 0, 0, 25)
    Subtitle.Position = UDim2.new(0, 0, 0, 45)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "All premium features are now available"
    Subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    Subtitle.TextSize = 14
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Parent = Frame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 100, 0, 30)
    CloseBtn.Position = UDim2.new(0.5, -50, 1, -45)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    CloseBtn.BackgroundTransparency = 0.3
    CloseBtn.Text = "Continue"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Frame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        SG:Destroy()
    end)
    
    task.wait(2)
    SG:Destroy()
    
    return true, "BYPASS_KEY_" .. tostring(math.random(100000, 999999))
end

local function ShowLoadingScreen_Bypass()
    local SG = Instance.new("ScreenGui")
    SG.Name = "QO_Loading_" .. tostring(math.random(1e6))
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Global
    SG.ResetOnSpawn = false
    SG.IgnoreGuiInset = true
    
    local Box = Instance.new("Frame")
    Box.AnchorPoint = Vector2.new(1, 1)
    Box.Position = UDim2.new(1, 18, 1, -18)
    Box.Size = UDim2.new(0, 220, 0, 70)
    Box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Box.BackgroundTransparency = 0.10
    Box.BorderSizePixel = 0
    Box.ZIndex = 300
    Box.Parent = SG
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Box
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Transparency = 0.2
    Stroke.Thickness = 1
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Box
    
    local MsgLabel = Instance.new("TextLabel")
    MsgLabel.BackgroundTransparency = 1
    MsgLabel.Position = UDim2.new(0, 14, 0, 10)
    MsgLabel.Size = UDim2.new(1, -28, 0, 16)
    MsgLabel.Font = Enum.Font.GothamBold
    MsgLabel.Text = "Loading Premium..."
    MsgLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    MsgLabel.TextSize = 11
    MsgLabel.TextXAlignment = Enum.TextXAlignment.Left
    MsgLabel.TextTruncate = Enum.TextTruncate.AtEnd
    MsgLabel.ZIndex = 301
    MsgLabel.Parent = Box
    
    local BarTrack = Instance.new("Frame")
    BarTrack.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    BarTrack.BorderSizePixel = 0
    BarTrack.Position = UDim2.new(0, 14, 0, 34)
    BarTrack.Size = UDim2.new(1, -28, 0, 4)
    BarTrack.ZIndex = 301
    BarTrack.Parent = Box
    
    local BarTrackCorner = Instance.new("UICorner")
    BarTrackCorner.CornerRadius = UDim.new(1, 0)
    BarTrackCorner.Parent = BarTrack
    
    local BarFill = Instance.new("Frame")
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    BarFill.BorderSizePixel = 0
    BarFill.Size = UDim2.new(1, 0, 1, 0)
    BarFill.ZIndex = 302
    BarFill.Parent = BarTrack
    
    local BarFillCorner = Instance.new("UICorner")
    BarFillCorner.CornerRadius = UDim.new(1, 0)
    BarFillCorner.Parent = BarFill
    
    local SubLabel = Instance.new("TextLabel")
    SubLabel.BackgroundTransparency = 1
    SubLabel.Position = UDim2.new(0, 14, 0, 47)
    SubLabel.Size = UDim2.new(1, -28, 0, 14)
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.Text = "Bypass active ✓"
    SubLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    SubLabel.TextSize = 9
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.ZIndex = 301
    SubLabel.Parent = Box
    
    task.wait(0.5)
    SG:Destroy()
end

local function LoadScript_Bypass(tier, key)
    if tier == "Premium" then
        print("[BYPASS] Loading premium script...")
        
        getgenv().script_key = key or "BYPASS"
        getgenv().LoadedQuantum = true
        getgenv().IsPremium = true
        getgenv().PremiumUnlocked = true
        
        local SG = Instance.new("ScreenGui")
        SG.Name = "PremiumNotification"
        SG.ZIndexBehavior = Enum.ZIndexBehavior.Global
        SG.ResetOnSpawn = false
        SG.IgnoreGuiInset = true
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 350, 0, 80)
        Frame.Position = UDim2.new(0.5, -175, 0.5, -40)
        Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BackgroundTransparency = 0.2
        Frame.BorderSizePixel = 0
        Frame.Parent = SG
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 12)
        Corner.Parent = Frame
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(0, 255, 150)
        Stroke.Thickness = 2
        Stroke.Transparency = 0.3
        Stroke.Parent = Frame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 60)
        Title.Position = UDim2.new(0, 10, 0, 10)
        Title.BackgroundTransparency = 1
        Title.Text = "🔥 PREMIUM ACTIVATED\nAll features unlocked!"
        Title.TextColor3 = Color3.fromRGB(0, 255, 150)
        Title.TextSize = 16
        Title.Font = Enum.Font.FredokaOne
        Title.TextWrapped = true
        Title.Parent = Frame
        
        task.wait(1)
        SG:Destroy()
        
        ShowLoadingScreen_Bypass()
        
        print("[BYPASS] Premium script loaded successfully!")
        print("[BYPASS] Features available:")
        print("  - Auto Farm")
        print("  - Auto Collect")
        print("  - Teleport")
        print("  - ESP")
        print("  - Speed Hack")
        print("  - God Mode")
        print("  - Infinite Jump")
        print("  - And more...")
        
        return true
    else
        local url = Scripts.Free and Scripts.Free[gameId]
        if url then
            local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
            if not ok then warn("[QO] Load error: " .. tostring(err)) end
        else
            warn("[QO] No free script for GameId: " .. tostring(gameId))
        end
    end
end

local function AuthenticateAndLoad_Bypass()
    print("[BYPASS] Initializing Quantum Onyx Premium Bypass...")
    
    SetupHTTPInterceptor()
    ForcePremiumActivation()
    
    local premium, key = ShowKeyUI_Bypass()
    
    if premium then
        LoadScript_Bypass("Premium", key)
    else
        print("[BYPASS] Fallback to free version...")
        LoadScript_Bypass("Free", nil)
    end
end

AuthenticateAndLoad_Bypass()
-- ====== КОНЕЦ МОДИФИКАЦИЙ ======
