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
local SCRIPT_ID = "0ae9fe4cf963e3a13d25eed0e2ce5940"
local FOLDER = "Quantum Onyx Hub"
local KEY_FILE = FOLDER .. "/Key.json"
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local gameId = game.GameId

-- ====== НАЧАЛО МОДИФИКАЦИЙ (БЕЗ ПЕРЕХВАТЧИКА) ======

-- 1. Принудительная активация премиум-доступа
local function ForcePremiumActivation()
    getgenv().script_key = "BYPASS_KEY_" .. tostring(math.random(100000, 999999))
    getgenv().LoadedQuantum = true
    getgenv().IsPremium = true
    
    -- Переопределяем функцию проверки ключа в глобальной таблице
    _G.VerifyKey = function(key, onStatus)
        if onStatus then
            onStatus("Key bypassed! Premium unlocked.", Color3.fromRGB(80, 230, 130))
        end
        return true, { 
            code = "KEY_VALID", 
            message = "Premium access granted via bypass",
            features = {
                auto_farm = true,
                auto_collect = true,
                teleport = true,
                esp = true,
                speed_hack = true,
                god_mode = true,
                infinite_jump = true,
                all_unlocked = true
            }
        }
    end
    
    -- Переопределяем функцию загрузки SDK
    _G.LoadSDK = function()
        return true, {
            script_id = SCRIPT_ID,
            check_key = function(key)
                return true, { code = "KEY_VALID", message = "Bypassed successfully" }
            end,
            load_script = function()
                print("[QO] Loading premium script...")
                getgenv().LoadedQuantum = true
                return true
            end
        }
    end
    
    -- Сохраняем фейковый ключ (чтобы не запрашивать при повторном запуске)
    if not isfolder(FOLDER) then makefolder(FOLDER) end
    pcall(writefile, KEY_FILE, HttpService:JSONEncode({ key = getgenv().script_key, bypass = true }))
    
    print("[BYPASS] Premium features are now active!")
end

-- 2. Функция показа уведомления (без лишних сложностей)
local function ShowNotification()
    local SG = Instance.new("ScreenGui")
    SG.Name = "BypassNotification"
    SG.ZIndexBehavior = Enum.ZIndexBehavior.Global
    SG.ResetOnSpawn = false
    SG.IgnoreGuiInset = true
    
    -- Пытаемся найти CoreGui, если не получается — используем Players.LocalPlayer
    local parent = game:GetService("CoreGui")
    if not parent then
        parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    SG.Parent = parent
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 100)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.Parent = SG
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.3
    Stroke.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "✅ PREMIUM UNLOCKED"
    Title.TextColor3 = Color3.fromRGB(0, 255, 150)
    Title.TextSize = 20
    Title.Font = Enum.Font.FredokaOne
    Title.Parent = Frame
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, 0, 0, 25)
    Subtitle.Position = UDim2.new(0, 0, 0, 45)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "All premium features are now available"
    Subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    Subtitle.TextSize = 14
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Parent = Frame
    
    task.wait(3)
    SG:Destroy()
end

-- 3. Запуск обхода
print("[BYPASS] Initializing Quantum Onyx Premium Bypass...")

-- Активируем премиум
ForcePremiumActivation()

-- Показываем уведомление
ShowNotification()

-- Теперь запускаем оригинальную систему авторизации, но все проверки уже переопределены
-- Это гарантирует, что скрипт продолжит работать, как обычно, но без запроса ключа
local function AuthenticateAndLoad()
    local SavedKey = LoadSavedKey()
    if SavedKey and SavedKey ~= "" then
        -- Используем переопределённую функцию VerifyKey
        local ok, status = VerifyKey(SavedKey, nil)
        if ok and type(status) == "table" and status.code == "KEY_VALID" then
            getgenv().script_key = SavedKey
            LoadScript("Premium", SavedKey)
            return
        else
            ClearKey()
        end
    end

    -- Вызываем оригинальную функцию ShowKeyUI, но она теперь не запросит ключ,
    -- потому что VerifyKey всегда возвращает KEY_VALID
    local premium, key = ShowKeyUI()
    if premium then
        LoadScript("Premium", key)
    else
        LoadScript("Free", nil)
    end
end

-- Запускаем
AuthenticateAndLoad()
-- ====== КОНЕЦ МОДИФИКАЦИЙ ======
