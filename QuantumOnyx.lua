-- ====== QUANTUM ONYX С ОТКЛЮЧЕННОЙ ПРОВЕРКОЙ ======
print("[BYPASS] Запуск...")

-- 1. Загружаем оригинальный скрипт
local scriptContent = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnxy/refs/heads/main/QuantumOnyx.lua")

-- 2. Добавляем в начало скрипта наш код обхода
local bypassCode = [[
    -- ====== ОТКЛЮЧЕНИЕ ПРОВЕРКИ КЛЮЧА ======
    print("[BYPASS] Отключение проверки ключа...")
    
    -- Устанавливаем флаги
    getgenv().LoadedQuantum = true
    getgenv().IsPremium = true
    getgenv().PremiumUnlocked = true
    getgenv().script_key = "BYPASS_123"
    
    -- Переопределяем функции проверки
    _G.VerifyKey = function(key, callback)
        if callback then
            callback("✅ Premium unlocked!", Color3.fromRGB(0, 255, 150))
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
    
    -- Если есть функция проверки статуса - переопределяем
    if _G.IsKeyVerified then
        _G.IsKeyVerified = function() return true end
    end
    if _G.GetKeyStatus then
        _G.GetKeyStatus = function() return "KEY_VALID" end
    end
    
    print("[BYPASS] ✅ Проверка ключа отключена!")
]]

-- 3. Объединяем код
local finalScript = bypassCode .. scriptContent

-- 4. Запускаем
loadstring(finalScript)()

print("[BYPASS] Готово! Скрипт запущен с отключенной проверкой ключа.")
