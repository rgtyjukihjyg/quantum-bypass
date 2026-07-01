-- ====== QUANTUM ONYX - ОБХОД ПРЕМИУМ-СКРИПТА ======
-- Этот код перехватывает загрузку премиум-скрипта и возвращает свой собственный.

print("[BYPASS] Запуск обхода...")

-- 1. Сохраняем оригинальную функцию HttpGet
local oldHttpGet = game.HttpGet

-- 2. Подменяем HttpGet
game.HttpGet = function(self, url, ...)
    if url and type(url) == "string" then
        -- Если это запрос к Luarmor (премиум-скрипт)
        if url:find("luarmor.net/files/v4/loaders") then
            print("[BYPASS] Перехвачен премиум-скрипт. Возвращаем свою версию.")
            
            -- Возвращаем СВОЙ премиум-скрипт (без проверок)
            return loadstring([[
                print("[PREMIUM] Наш премиум-скрипт загружен!")
                print("[PREMIUM] Все функции разблокированы.")
                
                -- Флаги для системы
                getgenv().LoadedQuantum = true
                getgenv().IsPremium = true
                getgenv().PremiumUnlocked = true
                
                -- ====== НАШИ ПРЕМИУМ-ФУНКЦИИ ======
                -- Здесь ты можешь добавить любые функции
                
                -- Автофарм (пример)
                _G.AutoFarm = function()
                    print("[PREMIUM] Автофарм запущен!")
                    -- Твой код автофарма
                end
                
                -- Телепорт (пример)
                _G.Teleport = function(pos)
                    if game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
                        print("[PREMIUM] Телепорт в " .. tostring(pos))
                    end
                end
                
                -- ESP (пример)
                _G.ESP = function()
                    print("[PREMIUM] ESP включен!")
                    -- Твой код ESP
                end
                
                print("[PREMIUM] ✅ Все функции готовы!")
                
                -- Возвращаем таблицу, чтобы скрипт не ругался
                return {
                    AutoFarm = _G.AutoFarm,
                    Teleport = _G.Teleport,
                    ESP = _G.ESP
                }
            ]])()
        end
        
        -- Если это запрос к SDK
        if url:find("sdkapi-public.luarmor.net") then
            print("[BYPASS] Перехвачен SDK. Возвращаем подделку.")
            return loadstring([[
                return {
                    check_key = function(key) 
                        return true, { code = "KEY_VALID" } 
                    end,
                    load_script = function()
                        print("[QO] Премиум загружен через обход")
                        getgenv().LoadedQuantum = true
                    end,
                    script_id = "0ae9fe4cf963e3a13d25eed0e2ce5940"
                }
            ]])()
        end
    end
    
    -- Если запрос не к Luarmor — используем оригинальную функцию
    return oldHttpGet(self, url, ...)
end

-- 3. Теперь загружаем оригинальный скрипт Quantum Onyx
print("[BYPASS] Загрузка оригинального Quantum Onyx...")

local scriptContent = oldHttpGet(game, "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")
if scriptContent then
    loadstring(scriptContent)()
    print("[BYPASS] Оригинальный скрипт загружен. Премиум заменён на наш.")
else
    print("[BYPASS] Не удалось загрузить оригинальный скрипт.")
end

print("[BYPASS] Готово! Теперь все премиум-функции — наши.")
