-- ====== QUANTUM ONYX С КАСТОМНЫМ КЛЮЧОМ (ИСПРАВЛЕННЫЙ) ======
print("[BYPASS] Загрузка Quantum Onyx с обходом формата ключа...")

-- Загружаем оригинальный скрипт
local originalScript = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")

-- Сохраняем оригинальные функции
local original_VerifyKey = VerifyKey
local original_LoadSDK = LoadSDK

-- ====== ГЛАВНАЯ ХИТРОСТЬ ======
-- Мы не будем проверять ключ вообще. Просто скажем, что он ВСЕГДА валидный.

-- Переопределяем функцию проверки ключа
_G.VerifyKey = function(keyStr, onStatus)
    print("[BYPASS] Получен ключ: " .. tostring(keyStr))
    
    -- Всегда возвращаем УСПЕХ, независимо от ключа
    if onStatus then
        onStatus("✅ Premium unlocked!", Color3.fromRGB(0, 255, 150))
    end
    
    return true, {
        code = "KEY_VALID",
        message = "Premium access granted (bypass)",
        -- Добавляем фейковые данные, чтобы скрипт думал, что ключ настоящий
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

-- Также переопределяем LoadSDK, чтобы он не проверял формат
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

-- Теперь загружаем оригинальный скрипт
local success, err = pcall(function()
    loadstring(originalScript)()
end)

if not success then
    print("[BYPASS] Ошибка при загрузке: " .. tostring(err))
    print("[BYPASS] Но байпас уже активен. Попробуй ввести ЛЮБОЙ ключ.")
end

print("[BYPASS] Готово! Введи ЛЮБОЙ ключ (например, 123) - он подойдет.")
print("[BYPASS] Или нажми 'Free Version' для бесплатной версии.")
