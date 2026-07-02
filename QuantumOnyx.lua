-- ============================================================
--  Quantum Onyx — Полная версия (только Free)
--  Система ключей полностью удалена.
--  Автоматически загружает бесплатный скрипт для текущей игры.
--  Источник: flazhy/QuantumOnyx
-- ============================================================

local Directory = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Games"

-- Только бесплатные скрипты (Premium удалён)
local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
        -- Добавляй сюда другие игры по мере необходимости
    }
}

local gameId = game.GameId
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ---- Вспомогательные утилиты (без ключей) ----
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

-- ---- Функция загрузки скрипта (только Free) ----
local function LoadScript()
    local url = Scripts.Free[gameId]
    if url then
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not ok then
            warn("[Quantum Onyx] Ошибка загрузки: " .. tostring(err))
        else
            print("[Quantum Onyx] Бесплатная версия загружена!")
        end
    else
        warn("[Quantum Onyx] Для этой игры нет бесплатного скрипта (GameId: " .. tostring(gameId) .. ")")
    end
end

-- ---- ЭКРАН ЗАГРУЗКИ (опционально, можно убрать) ----
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
        Text = "Loading Free Version...",
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
        MsgLabel.Text = "Loaded"
        MsgLabel.TextColor3 = Color3.fromRGB(160, 230, 160)
        BarFill.Size = UDim2.new(1, 0, 1, 0)
        BarFill.BackgroundColor3 = Color3.fromRGB(120, 210, 120)
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

-- ---- Запуск (без ключей, сразу Free) ----
task.spawn(function()
    local dismiss = ShowLoadingScreen()

    getgenv().LoadedQuantum = nil

    task.spawn(function()
        LoadScript()
        getgenv().LoadedQuantum = true
        task.wait(0.6)
        if dismiss then dismiss() end
    end)
end)
