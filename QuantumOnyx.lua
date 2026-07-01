-- ====== QUANTUM ONYX - ПОЛНЫЙ БАЙПАС (ВСЕ ПРОВЕРКИ) ======
print("[BYPASS] Загрузка полного байпаса...")

-- Загружаем оригинальный скрипт
local originalScript = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")

-- ====== 1. Переопределяем ВСЕ функции проверки ======

-- Главная проверка ключа
_G.VerifyKey = function(keyStr, onStatus)
    print("[BYPASS] Проверка ключа: " .. tostring(keyStr))
    if onStatus then
        onStatus("✅ Premium verified!", Color3.fromRGB(0, 255, 150))
    end
    return true, {
        code = "KEY_VALID",
        message = "Premium access granted",
        features = {
            auto_farm = true,
            auto_collect = true,
            teleport = true,
            esp = true,
            speed_hack = true,
            god_mode = true,
            infinite_jump = true
        }
    }
end

-- Функция загрузки SDK
_G.LoadSDK = function()
    return true, {
        script_id = "0ae9fe4cf963e3a13d25eed0e2ce5940",
        check_key = function(key)
            return true, { code = "KEY_VALID" }
        end,
        load_script = function()
            print("[QO] Premium script loaded")
            return true
        end,
        is_premium = function()
            return true -- ВАЖНО: всегда возвращаем true
        end
    }
end

-- ====== 2. Переопределяем функцию, которая проверяет, верифицирован ли ключ ======
-- Обычно это что-то типа IsKeyVerified() или GetKeyStatus()

_G.IsKeyVerified = function()
    return true
end

_G.GetKeyStatus = function()
    return "KEY_VALID"
end

-- ====== 3. Подменяем функцию ShowKeyUI, чтобы она сразу возвращала премиум ======
local function CustomShowKeyUI()
    print("[BYPASS] Пропускаем окно ввода ключа")
    
    -- Создаем фейковое окно, которое сразу закрывается
    local SG = Instance.new("ScreenGui")
    SG.Parent = game:GetService("CoreGui")
    SG.ResetOnSpawn = false
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 60)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -30)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.2
    Frame.Parent = SG
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "✅ PREMIUM ACTIVATED"
    Label.TextColor3 = Color3.fromRGB(0, 255, 150)
    Label.TextSize = 20
    Label.Font = Enum.Font.FredokaOne
    Label.Parent = Frame
    
    task.delay(2, function()
        SG:Destroy()
    end)
    
    -- Возвращаем успех
    return true, "BYPASS_KEY_123456"
end

-- Подменяем функцию
ShowKeyUI = CustomShowKeyUI

-- ====== 4. Загружаем оригинальный скрипт ======
local success, err = pcall(function()
    loadstring(originalScript)()
end)

if not success then
    print("[BYPASS] Ошибка: " .. tostring(err))
end

-- ====== 5. Дополнительная защита: каждые 5 секунд проверяем статус ======
task.spawn(function()
    while true do
        task.wait(5)
        -- Принудительно устанавливаем флаги
        getgenv().LoadedQuantum = true
        getgenv().IsPremium = true
        getgenv().PremiumUnlocked = true
        getgenv().script_key = "BYPASS_KEY_123456"
        
        -- Если есть глобальная переменная для статуса ключа - устанавливаем её
        if _G.KeyVerified ~= nil then
            _G.KeyVerified = true
        end
        if _G.PremiumStatus ~= nil then
            _G.PremiumStatus = "KEY_VALID"
        end
    end
end)

print("[BYPASS] ✅ Байпас активирован! Все премиум-функции разблокированы.")
print("[BYPASS] Если какая-то функция просит ключ - просто подожди 5 секунд.")
