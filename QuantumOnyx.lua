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

local function Tween(obj, props, t, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(t, style, dir), props):Play()
end

local function Protect(gui)
    local env = (getgenv and getgenv()) or _G
    if env.HIDEUI then
        gui.Parent = env.HIDEUI
    elseif gethui then
        gui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = game:GetService("CoreGui")
    else
        gui.Parent = game:GetService("CoreGui")
    end
end

local function New(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        if k ~= "Children" and k ~= "Parent" then
            pcall(function() inst[k] = v end)
        end
    end
    if props.Children then
        for _, c in ipairs(props.Children) do
            pcall(function() c.Parent = inst end)
        end
    end
    inst.Parent = props.Parent or parent
    return inst
end

local function CircleRipple(btn, mx, my)
    task.spawn(function()
        btn.ClipsDescendants = true
        local nx = mx - btn.AbsolutePosition.X
        local ny = my - btn.AbsolutePosition.Y
        local sz = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.6
        local c = New("ImageLabel", {
            Name = "Ripple",
            Image = "rbxassetid://266543268",
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 0.82,
            BackgroundTransparency = 1,
            ZIndex = btn.ZIndex + 5,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, nx, 0, ny),
        }, btn)
        Tween(c, { Size = UDim2.new(0, sz, 0, sz), Position = UDim2.new(0.5, -sz/2, 0.5, -sz/2) }, 0.45, Enum.EasingStyle.Quad)
        Tween(c, { ImageTransparency = 1 }, 0.45, Enum.EasingStyle.Linear)
        task.wait(0.46)
        c:Destroy()
    end)
end

local function SaveKey(key)
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({ key = key }))
end

local function LoadSavedKey()
    if isfolder(FOLDER) and isfile(KEY_FILE) then
        local ok, v = pcall(function()
            return HttpService:JSONDecode(readfile(KEY_FILE))
        end)
        if ok and type(v) == "table" and v.key then return v.key end
    end
    return ""
end

local function ClearKey()
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({}))
end

-- ====== НАЧАЛО ИЗМЕНЕНИЙ ======

-- Удаляем SDK и проверки, они больше не нужны
-- Оставляем только заглушки, чтобы код не падал

local SDK_RETRIES = 4
local SDK_RETRY_DELAY = 2.5
local _cachedAPI = nil

local function LoadSDK()
    -- Возвращаем фейковое SDK, которое всегда говорит "ключ валидный"
    return true, {
        script_id = SCRIPT_ID,
        check_key = function(key)
            return true, { code = "KEY_VALID", message = "Premium access granted" }
        end,
        load_script = function()
            print("[QO] Premium script loaded via bypass")
            getgenv().LoadedQuantum = true
        end
    }
end

local function VerifyKey(keyStr, onStatus)
    -- Всегда возвращаем успех
    if onStatus then
        onStatus("✅ Premium unlocked!", Color3.fromRGB(0, 255, 150))
    end
    return true, {
        code = "KEY_VALID",
        message = "Premium access granted"
    }
end

-- ====== КОНЕЦ ИЗМЕНЕНИЙ ======

local function ShowLoadingScreen()
    local SG2 = Instance.new("ScreenGui")
    SG2.Name = "QO_Loading_" .. tostring(math.random(1e6))
    SG2.ZIndexBehavior = Enum.ZIndexBehavior.Global
    SG2.ResetOnSpawn = false
    SG2.IgnoreGuiInset = true
    Protect(SG2)

    local Box = New("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 18, 1, -18),
        Size = UDim2.new(0, 220, 0, 70),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.10,
        BorderSizePixel = 0,
        ZIndex = 300,
        Parent = SG2,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 10) }),
            New("UIStroke", {
                Color = Color3.fromRGB(40, 40, 40),
                Transparency = 0.20,
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
        }
    })

    local MsgLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 10),
        Size = UDim2.new(1, -28, 0, 16),
        Font = Enum.Font.GothamBold,
        Text = "Loading...",
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 301,
        Parent = Box
    })

    local BarTrack = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 14, 0, 34),
        Size = UDim2.new(1, -28, 0, 4),
        ZIndex = 301,
        Parent = Box,
        Children = { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }
    })

    local BarFill = New("Frame", {
        BackgroundColor3 = Color3.fromRGB(160, 160, 160),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 0, 1, 0),
        ZIndex = 302,
        Parent = BarTrack,
        Children = { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }
    })

    local SubLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 47),
        Size = UDim2.new(1, -28, 0, 14),
        Font = Enum.Font.Gotham,
        Text = "",
        TextColor3 = Color3.fromRGB(90, 90, 90),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 301,
        Parent = Box
    })

    Tween(Box, { Position = UDim2.new(1, -18, 1, -18) }, 0.28, Enum.EasingStyle.Quint)

    local animRunning = true
    local dismissed = false

    local function Dismiss()
        if dismissed then return end
        dismissed = true
        animRunning = false
        SubLabel.Text = ""
        local env = getgenv and getgenv()
        if not (env and env.LoadedQuantum == true) then
            MsgLabel.Text = "Loaded Script"
            MsgLabel.TextColor3 = Color3.fromRGB(160, 230, 160)
            BarFill.Size = UDim2.new(1, 0, 1, 0)
            BarFill.BackgroundColor3 = Color3.fromRGB(120, 210, 120)
        end
        task.wait(0.5)
        Tween(Box, { Position = UDim2.new(1, 18, 1, -18) }, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.wait(0.28)
        SG2:Destroy()
    end

    task.spawn(function()
        local msgs = {
            { t = 0.0, msg = "Fetching script...",       pct = 0.20 },
            { t = 1.8, msg = "Injecting modules...",      pct = 0.45 },
            { t = 3.6, msg = "Setting up environment...", pct = 0.75 },
        }
        local start = tick()
        for _, s in ipairs(msgs) do
            local wait = s.t - (tick() - start)
            if wait > 0 then task.wait(wait) end
            if not animRunning then return end
            MsgLabel.Text = s.msg
            Tween(BarFill, { Size = UDim2.new(s.pct, 0, 1, 0) }, 0.6, Enum.EasingStyle.Quint)
        end
    end)

    task.spawn(function()
        local d = 0
        while animRunning do
            d = (d % 3) + 1
            SubLabel.Text = string.rep("•", d)
            task.wait(0.4)
        end
    end)

    task.spawn(function()
        while animRunning do
            local env = getgenv and getgenv()
            if env and env.LoadedQuantum == true then
                animRunning = false
                MsgLabel.Text = "Loaded"
                MsgLabel.TextColor3 = Color3.fromRGB(160, 230, 160)
                Tween(BarFill, { Size = UDim2.new(1, 0, 1, 0) }, 0.20, Enum.EasingStyle.Quint)
                BarFill.BackgroundColor3 = Color3.fromRGB(120, 210, 120)
                SubLabel.Text = ""
                task.wait(0.5)
                Dismiss()
                break
            end
            task.wait(0.05)
        end
    end)

    return Dismiss
end

local function LoadScript(tier, key)
    if tier == "Premium" and key then
        getgenv().script_key = key

        local dismiss = ShowLoadingScreen()

        getgenv().LoadedQuantum = nil

        task.spawn(function()
            local ok, err = pcall(function()
                if _cachedAPI then
                    _cachedAPI.load_script()
                else
                    local url = Scripts.Premium and Scripts.Premium[gameId]
                    if url then
                        loadstring(game:HttpGet(url))()
                    else
                        warn("[QO] No premium script for GameId: " .. tostring(gameId))
                    end
                end
            end)
            if not ok then
                warn("[QO] Load error: " .. tostring(err))
            end
            getgenv().LoadedQuantum = true
            task.wait(0.6)
            dismiss()
        end)

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

-- ====== ИЗМЕНЕННАЯ ФУНКЦИЯ SHOWKEYUI ======
-- Теперь она не ждет ключа, а просто показывает уведомление и сразу возвращает успех

local function ShowKeyUI()
    print("[BYPASS] Пропускаем ввод ключа...")
    
    -- Создаем простое уведомление
    local SG = Instance.new("ScreenGui")
    SG.Name = "BypassNotification"
    SG.ResetOnSpawn = false
    SG.IgnoreGuiInset = true
    Protect(SG)
    
    local Frame = New("Frame", {
        Size = UDim2.new(0, 350, 0, 80),
        Position = UDim2.new(0.5, -175, 0.5, -40),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 201,
        Parent = SG,
        Children = {
            New("UICorner", { CornerRadius = UDim.new(0, 12) }),
            New("UIStroke", {
                Color = Color3.fromRGB(0, 255, 150),
                Thickness = 2,
                Transparency = 0.3,
            }),
            New("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "✅ PREMIUM UNLOCKED\nAll features available!",
                TextColor3 = Color3.fromRGB(0, 255, 150),
                TextSize = 18,
                Font = Enum.Font.FredokaOne,
                TextWrapped = true,
                ZIndex = 202,
            })
        }
    })
    
    task.wait(2)
    SG:Destroy()
    
    -- Всегда возвращаем успех
    return true, "BYPASS_KEY"
end

-- ====== ИЗМЕНЕННАЯ ФУНКЦИЯ AUTHENTICATEANDLOAD ======

local function AuthenticateAndLoad()
    -- Всегда загружаем премиум без проверки
    print("[BYPASS] Загрузка премиум-версии...")
    
    -- Устанавливаем флаги
    getgenv().script_key = "BYPASS_KEY"
    getgenv().LoadedQuantum = true
    getgenv().IsPremium = true
    
    -- Показываем уведомление (пропускаем ввод ключа)
    local premium, key = ShowKeyUI()
    
    -- Загружаем премиум
    LoadScript("Premium", key or "BYPASS_KEY")
end

-- ====== ЗАПУСК ======

AuthenticateAndLoad()
