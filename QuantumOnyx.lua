-- ====== УПРОЩЕННЫЙ БАЙПАС QUANTUM ONYX ======
-- Этот код работает без сложных перехватчиков и совместим с большинством экзекьюторов.

print("[BYPASS] Запуск упрощенного байпаса...")

-- 1. Устанавливаем флаги, которые ждет скрипт
getgenv().LoadedQuantum = true
getgenv().IsPremium = true
getgenv().PremiumUnlocked = true
getgenv().script_key = "BYPASS_KEY_" .. tostring(math.random(100000, 999999))

-- 2. Переопределяем глобальные функции проверки
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
            print("[QO] Premium script loaded") 
            return true 
        end
    }
end

-- 3. Показываем уведомление (простое, без сложных UI)
local function ShowSimpleNotification()
    local success, errorMsg = pcall(function()
        local SG = Instance.new("ScreenGui")
        SG.Parent = game:GetService("CoreGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 300, 0, 60)
        Frame.Position = UDim2.new(0.5, -150, 0.5, -30)
        Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BackgroundTransparency = 0.2
        Frame.BorderSizePixel = 0
        Frame.Parent = SG
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = "✅ PREMIUM UNLOCKED"
        Label.TextColor3 = Color3.fromRGB(0, 255, 150)
        Label.TextSize = 22
        Label.Font = Enum.Font.FredokaOne
        Label.Parent = Frame
        
        task.wait(2.5)
        SG:Destroy()
    end)
    
    if not success then
        print("[BYPASS] Не удалось показать уведомление, но байпас активен.")
    end
end

-- 4. Показываем уведомление
ShowSimpleNotification()

print("[BYPASS] ✅ Байпас активирован! Все премиум-функции разблокированы.")

-- 5. Запускаем оригинальный скрипт, если он еще не загружен
-- Проверяем, не загружен ли уже оригинальный скрипт
if not _G.QuantumOnyxLoaded then
    _G.QuantumOnyxLoaded = true
    
    -- Пытаемся загрузить оригинальный скрипт, чтобы он использовал наши переопределения
    local success, errorMsg = pcall(function()
        -- Оригинальный скрипт Quantum Onyx
        local scriptContent = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")
        if scriptContent and #scriptContent > 100 then
            loadstring(scriptContent)()
            print("[BYPASS] Оригинальный скрипт Quantum Onyx загружен с байпасом.")
        else
            print("[BYPASS] Не удалось загрузить оригинальный скрипт. Возможно, он уже загружен.")
        end
    end)
    
    if not success then
        print("[BYPASS] Ошибка при загрузке оригинала: " .. tostring(errorMsg))
        print("[BYPASS] Но байпас активен — просто используй функции вручную.")
    end
else
    print("[BYPASS] Quantum Onyx уже загружен. Байпас активен.")
end

print("[BYPASS] Готово! Наслаждайся премиум-доступом.")
