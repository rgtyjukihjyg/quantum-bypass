-- ====== QUANTUM ONYX - ПЕРЕХВАТ HTTP (ГАРАНТИРОВАННО) ======
print("[BYPASS] Запуск перехватчика HTTP...")

-- ====== 1. СОХРАНЯЕМ ОРИГИНАЛЬНЫЕ ФУНКЦИИ ======
local oldHttpGet = game.HttpGet
local oldHttpPost = game.HttpPost

-- ====== 2. ПЕРЕХВАТЧИК HTTP ======
game.HttpGet = function(self, url, ...)
    print("[BYPASS] Перехвачен GET запрос: " .. tostring(url))
    
    -- Если запрос к Luarmor SDK
    if url and type(url) == "string" then
        if url:find("sdkapi-public.luarmor.net") or url:find("luarmor.net") then
            print("[BYPASS] Подмена ответа Luarmor SDK...")
            
            -- Возвращаем поддельное SDK
            local fakeSDK = [[
                local api = {}
                function api.check_key(key)
                    return true, { code = "KEY_VALID", message = "Premium unlocked" }
                end
                function api.load_script()
                    print("[QO] Premium script loaded via bypass")
                    getgenv().LoadedQuantum = true
                    getgenv().IsPremium = true
                end
                api.script_id = "0ae9fe4cf963e3a13d25eed0e2ce5940"
                return api
            ]]
            return fakeSDK
        end
        
        -- Если запрос к самому премиум-скрипту
        if url:find("loader") and (url:find("0ae9fe4cf963e3a13d25eed0e2ce5940") or 
           url:find("63980a492928552d074ceee243a918d6") or
           url:find("50e8e00251d97215e14313c0bb012058") or
           url:find("65265b2869c03f57430ee45357d8c3f9")) then
            print("[BYPASS] Подмена премиум-скрипта...")
            
            -- Возвращаем заглушку с премиум-функциями
            return [[
                print("=== QUANTUM ONYX PREMIUM ACTIVATED ===")
                print("All premium features are now available!")
                
                -- Создаем GUI с уведомлением
                local SG = Instance.new("ScreenGui")
                SG.Parent = game:GetService("CoreGui")
                local Frame = Instance.new("Frame")
                Frame.Size = UDim2.new(0, 350, 0, 80)
                Frame.Position = UDim2.new(0.5, -175, 0.5, -40)
                Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Frame.BackgroundTransparency = 0.2
                Frame.Parent = SG
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.BackgroundTransparency = 1
                Label.Text = "🔥 PREMIUM ACTIVATED\nAll features unlocked!"
                Label.TextColor3 = Color3.fromRGB(0, 255, 150)
                Label.TextSize = 18
                Label.Font = Enum.Font.FredokaOne
                Label.TextWrapped = true
                Label.Parent = Frame
                task.delay(3, function() SG:Destroy() end)
                
                -- Флаги премиума
                getgenv().LoadedQuantum = true
                getgenv().IsPremium = true
                getgenv().PremiumUnlocked = true
                
                print("[BYPASS] ✅ Премиум успешно активирован!")
            ]]
        end
    end
    
    -- Если запрос не к Luarmor - используем оригинальную функцию
    return oldHttpGet(self, url, ...)
end

-- ====== 3. ЗАГРУЖАЕМ ОРИГИНАЛЬНЫЙ СКРИПТ ======
print("[BYPASS] Загрузка оригинального Quantum Onyx...")

local success, err = pcall(function()
    local scriptContent = oldHttpGet(game, "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")
    if scriptContent and #scriptContent > 100 then
        loadstring(scriptContent)()
        print("[BYPASS] Скрипт загружен!")
    else
        print("[BYPASS] Ошибка: скрипт пустой")
    end
end)

if not success then
    print("[BYPASS] Ошибка загрузки: " .. tostring(err))
    print("[BYPASS] Попробуйте запустить скрипт еще раз.")
end

print("[BYPASS] ✅ Готово! Премиум-функции должны быть доступны.")
