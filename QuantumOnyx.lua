-- ====== QUANTUM ONYX - ПОЛНОСТЬЮ БЕЗ КЛЮЧА ======
-- В этом коде нет ни одной проверки ключа.
-- Он просто загружает премиум-скрипт напрямую.

print("[BYPASS] Загрузка премиум-версии без ключа...")

-- 1. Устанавливаем флаги
getgenv().LoadedQuantum = true
getgenv().IsPremium = true
getgenv().PremiumUnlocked = true
getgenv().script_key = "BYPASS"

-- 2. Ссылки на скрипты
local Directory = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Games"
local Api = "https://api.luarmor.net/files/v4/loaders"

local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
    },
    Premium = {
        [994732206] = Api .. "/0ae9fe4cf963e3a13d25eed0e2ce5940.lua",
        [10004244222] = Api .. "/63980a492928552d074ceee243a918d6.lua",
        [9792947201] = Api .. "/50e8e00251d97215e14313c0bb012058.lua",
        [10200395747] = Api .. "/65265b2869c03f57430ee45357d8c3f9.lua"
    }
}

local gameId = game.GameId

-- 3. Показываем уведомление
local function ShowNotification()
    local SG = Instance.new("ScreenGui")
    SG.Parent = game:GetService("CoreGui")
    SG.ResetOnSpawn = false
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 350, 0, 80)
    Frame.Position = UDim2.new(0.5, -175, 0.5, -40)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.2
    Frame.Parent = SG
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "🔥 PREMIUM ACTIVATED\nAll features unlocked!"
    Label.TextColor3 = Color3.fromRGB(0, 255, 150)
    Label.TextSize = 18
    Label.Font = Enum.Font.FredokaOne
    Label.TextWrapped = true
    Label.Parent = Frame
    
    task.delay(3, function()
        SG:Destroy()
    end)
end

ShowNotification()

-- 4. Загружаем премиум-скрипт
local url = Scripts.Premium[gameId]
if url then
    print("[BYPASS] Загрузка премиум-скрипта для GameId: " .. gameId)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not success then
        print("[BYPASS] Ошибка загрузки: " .. tostring(err))
        print("[BYPASS] Пробуем загрузить бесплатную версию...")
        local freeUrl = Scripts.Free[gameId]
        if freeUrl then
            loadstring(game:HttpGet(freeUrl))()
        end
    end
else
    print("[BYPASS] Нет премиум-скрипта для этой игры. Загружаем бесплатный...")
    local freeUrl = Scripts.Free[gameId]
    if freeUrl then
        loadstring(game:HttpGet(freeUrl))()
    end
end

print("[BYPASS] Готово!")
