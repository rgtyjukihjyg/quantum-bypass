-- ====== QUANTUM ONYX С КАСТОМНЫМ КЛЮЧОМ ======
-- Этот код загружает ОРИГИНАЛЬНЫЙ скрипт, но добавляет свой собственный ключ.
-- Ты вводишь свой ключ — и получаешь премиум.

print("[BYPASS] Загрузка Quantum Onyx с кастомным ключом...")

-- Загружаем оригинальный скрипт
local originalScript = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")

-- Создаем НОВУЮ функцию VerifyKey, которая заменяет оригинальную
local function CustomVerifyKey(keyStr, onStatus)
    -- НАШ КЛЮЧ (ты можешь изменить его на любой)
    local MY_KEY = "HACKER2026"
    
    -- Проверяем, совпадает ли введенный ключ с нашим
    if keyStr == MY_KEY then
        -- Если совпадает — говорим, что ключ валидный
        if onStatus then
            onStatus("✅ Premium unlocked via custom key!", Color3.fromRGB(0, 255, 150))
        end
        return true, {
            code = "KEY_VALID",
            message = "Premium access granted with custom key"
        }
    else
        -- Если не совпадает — запускаем ОРИГИНАЛЬНУЮ проверку
        -- (чтобы можно было использовать и настоящие ключи)
        return original_VerifyKey(keyStr, onStatus)
    end
end

-- Сохраняем оригинальную функцию
local original_VerifyKey = VerifyKey

-- Подменяем функцию VerifyKey на нашу
VerifyKey = CustomVerifyKey

-- Теперь загружаем и запускаем оригинальный скрипт
loadstring(originalScript)()

print("[BYPASS] Готово! Введи ключ: HACKER2026")
print("[BYPASS] Или используй обычные ключи — они тоже работают.")
