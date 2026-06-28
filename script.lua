-- Khởi tạo UI Library (Tự động tối ưu hóa cho cả PC và Mobile)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cấu hình khung menu nhỏ gọn mang tên bạn
local Window = Fluent:CreateWindow({
    Title = "TRUNG KIEN HITBOX",
    SubTitle = "TikTok: trungkiendzvcl231",
    TabWidth = 140,
    Size = UDim2.fromOffset(450, 340), -- Kích thước nhỏ gọn, vừa vặn màn hình điện thoại và PC
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Nhấn Ctrl trên PC để ẩn/hiện menu
})

-- Tạo tab Chức năng chính
local Tabs = {
    Main = Window:AddTab({ Title = "Hitbox Bá Đạo", Icon = "crosshair" })
}

-- Biến lưu cấu hình mặc định
local HitboxEnabled = false
local HitboxSize = 10 -- Kích thước mặc định khi vừa bật
local HitboxTransparency = 0.5
local HitboxColor = Color3.fromRGB(255, 0, 0) -- Mặc định là màu đỏ
local RGBEnabled = false

-- Vòng lặp Hack Hitbox (Chạy ngầm liên tục)
task.spawn(function()
    while task.wait(0.1) do
        if HitboxEnabled then
            -- Tính năng 7 màu nếu được bật
            if RGBEnabled then
                local tick = tick()
                HitboxColor = Color3.fromHSV(tick % 5 / 5, 1, 1)
            end

            -- Quét tất cả người chơi trong game
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer and player.Character then
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- Phóng to Hitbox cực đại (Max 500) theo Size người dùng chọn
                        humanoidRootPart.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        humanoidRootPart.Transparency = HitboxTransparency
                        humanoidRootPart.Color = HitboxColor
                        humanoidRootPart.Material = Enum.Material.Neon -- Phát sáng cho ngầu
                        humanoidRootPart.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- ==================== GIAO DIỆN CHỨC NĂNG ====================

-- 1. Chức năng Bật Hitbox
Tabs.Main:AddToggle("ToggleHitbox", {
    Title = "Bật Hitbox",
    Default = false,
    Callback = function(Value)
        HitboxEnabled = Value
        if not Value then
            -- Khi tắt hack, trả hitbox của đối thủ về bình thường
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
})

-- 2. THANH CHỈNH HITBOX SIZE (Đã nâng lên MAX 500)
Tabs.Main:AddSlider("SizeSlider", {
    Title = "Hitbox Size",
    Description = "Chỉnh kích thước to/nhỏ của hộp Hitbox (Max 500 siêu bá đạo)",
    Default = 10,
    Min = 2,    -- Kích thước nhỏ nhất (bình thường)
    Max = 500,  -- Siêu to khổng lồ bao phủ toàn bộ map
    Rounding = 1,
    Callback = function(Value)
        HitboxSize = Value
    end
})

-- 3. Chức năng chọn độ trong suốt Hitbox Transparency
Tabs.Main:AddSlider("OpacitySlider", {
    Title = "Hitbox Transparency",
    Description = "Chỉnh độ mờ của hộp Hitbox (0 là đậm đặc, 1 là tàng hình)",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Callback = function(Value)
        HitboxTransparency = Value
    end
})

-- 4. Thanh chọn màu Hitbox & Chế độ 7 màu (RGB)
Tabs.Main:AddColorpicker("Colorpicker", {
    Title = "Chọn Màu Hitbox",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        HitboxColor = Value
    end
})

Tabs.Main:AddToggle("RGBToggle", {
    Title = "Bật Chế Độ 7 Màu (RGB)",
    Default = false,
    Callback = function(Value)
        RGBEnabled = Value
    end
})

-- Thông báo kích hoạt thành công
Window:SelectTab(Tabs.Main)
Fluent:Notify({
    Title = "TRUNG KIEN HITBOX MAX SIZE",
    Content = "Đã mở khóa giới hạn Size 500! Kênh TikTok: trungkiendzvcl231",
    Duration = 5
})
