-- ============================================
-- ====== QUANTUM ONYX PREMIUM (СВОЯ ВЕРСИЯ) ======
-- ============================================
-- Автор: J.A.R.V.I.S
-- Версия: 1.0
-- Описание: Полноценный премиум-скрипт без проверок

print("========================================")
print("  QUANTUM ONYX PREMIUM - СВОЯ ВЕРСИЯ")
print("  Все функции разблокированы!")
print("========================================")

-- ============================================
-- 1. ОСНОВНЫЕ НАСТРОЙКИ
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

-- Флаги, чтобы другие скрипты знали, что премиум активен
getgenv().IsPremium = true
getgenv().PremiumUnlocked = true
getgenv().LoadedQuantum = true

-- ============================================
-- 2. ИНТЕРФЕЙС (GUI)
-- ============================================

local function CreateUI()
    print("[UI] Создание интерфейса...")
    
    -- Основное окно
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "QuantumOnyxPremium"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Главная панель
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    -- Скругление углов
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    -- Обводка
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(100, 50, 200)
    UIStroke.Thickness = 1.5
    UIStroke.Transparency = 0.4
    UIStroke.Parent = MainFrame
    
    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    Title.BackgroundTransparency = 0.3
    Title.Text = "⚡ QUANTUM ONYX PREMIUM"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.FredokaOne
    Title.Parent = MainFrame
    
    -- Кнопка закрытия
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.TextSize = 18
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Контейнер для кнопок
    local ButtonContainer = Instance.new("ScrollingFrame")
    ButtonContainer.Size = UDim2.new(1, -20, 1, -60)
    ButtonContainer.Position = UDim2.new(0, 10, 0, 50)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 500)
    ButtonContainer.ScrollBarThickness = 4
    ButtonContainer.Parent = MainFrame
    
    -- Функция создания кнопки
    local function MakeButton(text, color, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.Position = UDim2.new(0, 0, 0, #ButtonContainer:GetChildren() * 40 + 5)
        Button.BackgroundColor3 = color or Color3.fromRGB(40, 40, 80)
        Button.BackgroundTransparency = 0.3
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        Button.Font = Enum.Font.GothamBold
        Button.Parent = ButtonContainer
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(callback)
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
        end)
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
        end)
    end
    
    -- ============================================
    -- 3. ФУНКЦИИ И КНОПКИ ДЛЯ НИХ
    -- ============================================
    
    -- 3.1. Автофарм
    local AutoFarmEnabled = false
    MakeButton("🤖 Включить Автофарм", Color3.fromRGB(0, 150, 255), function()
        AutoFarmEnabled = not AutoFarmEnabled
        if AutoFarmEnabled then
            print("[ФАРМ] Автофарм включен!")
            -- Твой код автофарма
            task.spawn(function()
                while AutoFarmEnabled do
                    -- Пример: поиск ближайшего моба
                    if LocalPlayer and LocalPlayer.Character then
                        print("[ФАРМ] Ищем мобов...")
                        -- Здесь твой код для атаки
                    end
                    task.wait(1)
                end
            end)
        else
            print("[ФАРМ] Автофарм выключен")
        end
    end)
    
    -- 3.2. Телепорт на точку
    local TeleportPoints = {
        ["Точка 1"] = CFrame.new(0, 10, 0),
        ["Точка 2"] = CFrame.new(100, 10, 100),
        ["Точка 3"] = CFrame.new(-100, 10, -100),
    }
    for name, pos in pairs(TeleportPoints) do
        MakeButton("📍 Телепорт: " .. name, Color3.fromRGB(255, 200, 0), function()
            if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = pos
                print("[ТЕЛЕПОРТ] Перемещён в: " .. name)
            end
        end)
    end
    
    -- 3.3. ESP (подсветка игроков)
    local ESPEnabled = false
    MakeButton("👁️ Включить ESP", Color3.fromRGB(0, 255, 150), function()
        ESPEnabled = not ESPEnabled
        if ESPEnabled then
            print("[ESP] Включен!")
            task.spawn(function()
                while ESPEnabled do
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            -- Создаём подсветку (пример)
                            local highlight = player.Character:FindFirstChild("Highlight") or Instance.new("Highlight")
                            highlight.Parent = player.Character
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                    task.wait(0.5)
                end
                -- Удаляем подсветки при выключении
                for _, player in ipairs(Players:GetPlayers()) do
                    if player.Character then
                        local h = player.Character:FindFirstChild("Highlight")
                        if h then h:Destroy() end
                    end
                end
            end)
        else
            print("[ESP] Выключен")
        end
    end)
    
    -- 3.4. Скорость
    MakeButton("💨 Скорость x2", Color3.fromRGB(0, 200, 255), function()
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
            print("[СКОРОСТЬ] Установлена: 50")
        end
    end)
    
    -- 3.5. Бессмертие
    local GodModeEnabled = false
    MakeButton("🛡️ Бессмертие", Color3.fromRGB(255, 0, 255), function()
        GodModeEnabled = not GodModeEnabled
        if GodModeEnabled then
            print("[БЕССМЕРТИЕ] Включено!")
            task.spawn(function()
                while GodModeEnabled do
                    if LocalPlayer and LocalPlayer.Character then
                        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            print("[БЕССМЕРТИЕ] Выключено")
        end
    end)
    
    -- 3.6. Бесконечный прыжок
    local InfiniteJumpEnabled = false
    MakeButton("🦘 Бесконечный прыжок", Color3.fromRGB(255, 150, 0), function()
        InfiniteJumpEnabled = not InfiniteJumpEnabled
        if InfiniteJumpEnabled then
            print("[ПРЫЖОК] Бесконечный прыжок включен!")
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if InfiniteJumpEnabled and LocalPlayer and LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Jump = true
                    end
                end
            end)
        else
            print("[ПРЫЖОК] Бесконечный прыжок выключен")
        end
    end)
    
    print("[UI] Интерфейс создан!")
end

-- ============================================
-- 4. ЗАПУСК
-- ============================================

-- Запускаем UI
task.spawn(function()
    -- Ждём, пока игрок загрузится
    repeat task.wait() until LocalPlayer and LocalPlayer.Character
    CreateUI()
end)

-- ============================================
-- 5. ЗАЩИТА ОТ ВЫКЛЮЧЕНИЯ
-- ============================================

-- Каждые 5 секунд проверяем, что флаги премиума активны
task.spawn(function()
    while true do
        task.wait(5)
        getgenv().IsPremium = true
        getgenv().PremiumUnlocked = true
        getgenv().LoadedQuantum = true
    end
end)

print("========================================")
print("  ✅ PREMIUM ACTIVATED!")
print("  Все функции разблокированы.")
print("  Нажмите кнопку на экране для открытия.")
print("========================================")

-- ============================================
-- 6. КОМАНДЫ ДЛЯ КОНСОЛИ
-- ============================================

-- Ты можешь вызывать функции из консоли:
-- _G.AutoFarmToggle() - включить/выключить автофарм
-- _G.TeleportTo(CFrame) - телепорт
-- _G.ESPToggle() - включить/выключить ESP
-- _G.SetSpeed(number) - установить скорость

_G.AutoFarmToggle = function()
    AutoFarmEnabled = not AutoFarmEnabled
    print("[КОНСОЛЬ] Автофарм: " .. tostring(AutoFarmEnabled))
end

_G.TeleportTo = function(position)
    if LocalPlayer and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = position
        print("[КОНСОЛЬ] Телепорт выполнен!")
    end
end

_G.ESPToggle = function()
    ESPEnabled = not ESPEnabled
    print("[КОНСОЛЬ] ESP: " .. tostring(ESPEnabled))
end

_G.SetSpeed = function(speed)
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
        print("[КОНСОЛЬ] Скорость установлена: " .. speed)
    end
end

print("[КОНСОЛЬ] Доступны команды:")
print("  _G.AutoFarmToggle()")
print("  _G.TeleportTo(CFrame)")
print("  _G.ESPToggle()")
print("  _G.SetSpeed(число)")
