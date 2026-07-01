-- ====== QUANTUM ONYX - ПОЛНЫЙ ОБХОД С ПОДМЕНОЙ ПРЕМИУМ-ФУНКЦИЙ ======
print("[BYPASS] Запуск полного обхода...")

-- 1. Загружаем оригинальный скрипт
local originalScript = game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")

-- 2. Создаём НАШИ премиум-функции (которые будут работать без ключа)
local myPremiumScript = [[
    print("[PREMIUM] Загрузка премиум-функций...")
    
    -- ====== НАШИ ПРЕМИУМ-ФУНКЦИИ ======
    -- Здесь ты можешь добавить ЛЮБЫЕ функции, которые хочешь
    
    -- Пример: автофарм
    _G.AutoFarm = function()
        print("[PREMIUM] Автофарм активирован!")
        -- Твой код автофарма
    end
    
    -- Пример: телепорт
    _G.Teleport = function(position)
        if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
            print("[PREMIUM] Телепорт выполнен!")
        end
    end
    
    -- Пример: ESP
    _G.ESP = function()
        print("[PREMIUM] ESP активирован!")
        -- Твой код ESP
    end
    
    -- Пример: скорость
    _G.SpeedHack = function(speed)
        if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
            print("[PREMIUM] Скорость установлена: " .. speed)
        end
    end
    
    -- Флаг, что премиум загружен
    getgenv().PremiumLoaded = true
    getgenv().IsPremium = true
    getgenv().LoadedQuantum = true
    
    print("[PREMIUM] ✅ Все премиум-функции загружены!")
]]

-- 3. Перехватываем HTTP-запросы для подмены премиум-скрипта
local oldHttpGet = game.HttpGet
game.HttpGet = function(self, url, ...)
    if url and type(url) == "string" then
        -- Если это запрос к Luarmor (премиум-скрипт)
        if url:find("luarmor.net/files/v4/loaders") or 
           url:find("0ae9fe4cf963e3a13d25eed0e2ce5940") or
           url:find("63980a492928552d074ceee243a918d6") or
           url:find("50e8e00251d97215e14313c0bb012058") or
           url:find("65265b2869c03f57430ee45357d8c3f9") then
            
            print("[BYPASS] Перехвачен запрос к премиум-скрипту. Возвращаем свои функции.")
            return myPremiumScript
        end
        
        -- Если это запрос к SDK
        if url:find("sdkapi-public.luarmor.net") then
            print("[BYPASS] Перехвачен запрос к SDK. Возвращаем подделку.")
            return [[
                return {
                    check_key = function(key) return true, { code = "KEY_VALID" } end,
                    load_script = function() 
                        print("[QO] Premium loaded via bypass")
                        getgenv().LoadedQuantum = true
                    end,
                    script_id = "0ae9fe4cf963e3a13d25eed0e2ce5940"
                }
            ]]
        end
    end
    -- Если не наш URL - используем оригинальную функцию
    return oldHttpGet(self, url, ...)
end

-- 4. Запускаем оригинальный скрипт
local success, err = pcall(function()
    loadstring(originalScript)()
end)

if not success then
    print("[BYPASS] Ошибка: " .. tostring(err))
end

print("[BYPASS] ✅ Готово! Премиум-функции заменены на наши.")
print("[BYPASS] Используй команды: _G.AutoFarm(), _G.Teleport(CFrame), _G.ESP(), _G.SpeedHack(число)")
