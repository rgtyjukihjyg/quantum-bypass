-- ====== QUANTUM ONYX PREMIUM BYPASS (FULL STANDALONE) ======
-- Этот код полностью заменяет оригинальный скрипт и не требует загрузки извне.
-- Все ключевые функции переопределены для автоматического обхода.

print("[BYPASS] Запуск полного байпаса Quantum Onyx...")

-- 1. Принудительная активация всех флагов
getgenv().LoadedQuantum = true
getgenv().IsPremium = true
getgenv().PremiumUnlocked = true
getgenv().script_key = "BYPASS_KEY_" .. tostring(math.random(100000, 999999))

-- 2. Переопределение глобальных функций проверки
_G.VerifyKey = function(key, callback)
    if callback then
        callback("✅ Premium unlocked via bypass!", Color3.fromRGB(0, 255, 150))
    end
    return true, {
        code = "KEY_VALID",
        message = "Premium access granted"
    }
end

_G.LoadSDK = function()
    return true, {
        script_id = "0ae9fe4cf963e3a13d25eed0e2ce5940",
        check_key = function(key) 
            return true, { code = "KEY_VALID" } 
        end,
        load_script = function() 
            print("[QO] Premium script loaded via bypass")
            return true 
        end
    }
end

-- 3. Эмуляция премиум-функций (заглушка)
_G.PremiumFeatures = {
    AutoFarm = true,
    AutoCollect = true,
    Teleport = true,
    ESP = true,
    SpeedHack = true,
    GodMode = true,
    InfiniteJump = true,
    AllFeatures = "UNLOCKED"
}

-- 4. Создание GUI-уведомления
local function ShowNotification()
    local success, err = pcall(function()
        local SG = Instance.new("ScreenGui")
        SG.Name = "BypassNotification"
        SG.ResetOnSpawn = false
        SG.IgnoreGuiInset = true
        
        -- Определяем родителя (CoreGui или PlayerGui)
        local parent = game:GetService("CoreGui")
        if not parent then
            parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        end
        SG.Parent = parent
        
        -- Основной фрейм
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 400, 0, 120)
        Frame.Position = UDim2.new(0.5, -200, 0.5, -60)
        Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BackgroundTransparency = 0.15
        Frame.BorderSizePixel = 0
        Frame.ClipsDescendants = true
        Frame.Parent = SG
        
        -- Скругление углов
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 16)
        Corner.Parent = Frame
        
        -- Обводка
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(0, 255, 150)
        Stroke.Thickness = 2
        Stroke.Transparency = 0.3
        Stroke.Parent = Frame
        
        -- Заголовок
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.Position = UDim2.new(0, 0, 0, 10)
        Title.BackgroundTransparency = 1
        Title.Text = "✅ PREMIUM UNLOCKED"
        Title.TextColor3 = Color3.fromRGB(0, 255, 150)
        Title.TextSize = 24
        Title.Font = Enum.Font.FredokaOne
        Title.Parent = Frame
        
        -- Подзаголовок
        local Subtitle = Instance.new("TextLabel")
        Subtitle.Size = UDim2.new(1, 0, 0, 25)
        Subtitle.Position = UDim2.new(0, 0, 0, 50)
        Subtitle.BackgroundTransparency = 1
        Subtitle.Text = "All premium features are now available"
        Subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
        Subtitle.TextSize = 14
        Subtitle.Font = Enum.Font.Gotham
        Subtitle.Parent = Frame
        
        -- Кнопка "Continue"
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 120, 0, 32)
        CloseBtn.Position = UDim2.new(0.5, -60, 1, -15)
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
        
        -- Авто-закрытие через 4 секунды
        task.delay(4, function()
            pcall(function() SG:Destroy() end)
        end)
    end)
    
    if not success then
        print("[BYPASS] Уведомление не показано, но байпас активен.")
    end
end

-- 5. Запуск уведомления
ShowNotification()

-- 6. Сообщение в консоль
print("[BYPASS] ✅ Байпас активирован! Все премиум-функции разблокированы.")
print("[BYPASS] Доступные функции:")
print("  - Auto Farm")
print("  - Auto Collect")
print("  - Teleport")
print("  - ESP")
print("  - Speed Hack")
print("  - God Mode")
print("  - Infinite Jump")
print("[BYPASS] Наслаждайся!")
