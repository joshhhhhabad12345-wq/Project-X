-- Aurora executor/hub v1.1 (ano_jay?!)
-- syntax highlight is currently brocken, but it doesnt effect your script, just ignore it lmao

local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LogService = game:GetService("LogService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local ACCENT_COLOR = Color3.fromRGB(0, 255, 170)
local BG_COLOR = Color3.fromRGB(5, 5, 8)
local GLASS_TRANSPARENCY = 0.25
local PROXY_URL = "https://scriptblox.com/api/script/search?q=%s&max=10&mode=free&page=%d"

-- Filesystem Wrappers (Safe loading for all executors)
local hasFileSystem = (writefile and readfile and isfolder and makefolder and listfiles)
if hasFileSystem and not isfolder("AuroraScripts") then
	makefolder("AuroraScripts")
end
local SessionScripts = {} -- Fallback if executor lacks file system

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AuroraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Floating Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "AuroraToggle"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.5, -22, 0, 10)
ToggleBtn.BackgroundColor3 = BG_COLOR
ToggleBtn.BackgroundTransparency = 0.1
ToggleBtn.Text = "A"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 24
ToggleBtn.TextColor3 = ACCENT_COLOR
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = ACCENT_COLOR
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.5
ToggleStroke.Parent = ToggleBtn

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.5, -200)
Main.BackgroundColor3 = BG_COLOR
Main.BackgroundTransparency = GLASS_TRANSPARENCY
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
	ColorSequenceKeypoint.new(1, Color3.new(0.7, 0.7, 0.8))
}
UIGradient.Rotation = 45
UIGradient.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.85
UIStroke.Thickness = 1
UIStroke.Parent = Main

-- Load Dialog Modal
local LoadModal = Instance.new("Frame")
LoadModal.Size = UDim2.new(1, 0, 1, 0)
LoadModal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadModal.BackgroundTransparency = 0.5
LoadModal.ZIndex = 100
LoadModal.Visible = false
LoadModal.Parent = Main

local ModalCard = Instance.new("Frame")
ModalCard.Size = UDim2.new(0, 300, 0, 200)
ModalCard.Position = UDim2.new(0.5, -150, 0.5, -100)
ModalCard.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ModalCard.ZIndex = 101
ModalCard.Parent = LoadModal
Instance.new("UICorner", ModalCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", ModalCard).Color = Color3.fromRGB(40, 40, 50)

local ModalTitle = Instance.new("TextLabel")
ModalTitle.Size = UDim2.new(1, 0, 0, 40)
ModalTitle.BackgroundTransparency = 1
ModalTitle.Text = "Please Select Your Choice:"
ModalTitle.Font = Enum.Font.GothamBold
ModalTitle.TextSize = 16
ModalTitle.TextColor3 = Color3.new(1, 1, 1)
ModalTitle.ZIndex = 102
ModalTitle.Parent = ModalCard

local function createModalBtn(text, yPos, color, txtColor)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -40, 0, 35)
	btn.Position = UDim2.new(0, 20, 0, yPos)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = txtColor
	btn.ZIndex = 102
	btn.Parent = ModalCard
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local LoadExecutorBtn = createModalBtn("1: Load on Executor Tab", 50, Color3.fromRGB(30, 30, 35), Color3.new(1, 1, 1))
local DirectExecBtn = createModalBtn("2: Direct Execution", 95, ACCENT_COLOR, Color3.fromRGB(10, 10, 15))
local CancelBtn = createModalBtn("3: Cancel", 140, Color3.fromRGB(200, 50, 50), Color3.new(1, 1, 1))

local currentScriptToLoad = ""

DirectExecBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function() loadstring(currentScriptToLoad)() end)
	if not success then warn("Aurora Error: " .. err) end
	LoadModal.Visible = false
end)

CancelBtn.MouseButton1Click:Connect(function()
	LoadModal.Visible = false
end)


-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BackgroundTransparency = 0.4
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Text = "AURORA"
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = ACCENT_COLOR
Title.TextSize = 22
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Parent = Sidebar

-- Containers
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -160, 1, -20)
Container.Position = UDim2.new(0, 155, 0, 10)
Container.BackgroundTransparency = 1
Container.Parent = Main

-- Base Tab Creation Helper
local function createTab(name)
	local tab = Instance.new("CanvasGroup")
	tab.Name = name
	tab.Size = UDim2.new(1, 0, 1, 0)
	tab.BackgroundTransparency = 1
	tab.Visible = false
	tab.GroupTransparency = 1
	tab.Parent = Container
	return tab
end

local HomeTab = createTab("HomeTab")
local ExecutorTab = createTab("ExecutorTab")
local HubTab = createTab("HubTab")
local CollectionTab = createTab("CollectionTab")
local ConsoleTab = createTab("ConsoleTab")
local SettingsTab = createTab("SettingsTab")
HomeTab.Visible = true -- Default Tab
HomeTab.GroupTransparency = 0

-- ==========================================
-- [[ HOME TAB ]]
-- ==========================================
local ProfilePic = Instance.new("ImageLabel")
ProfilePic.Size = UDim2.new(0, 70, 0, 70)
ProfilePic.Position = UDim2.new(0, 10, 0, 10)
ProfilePic.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ProfilePic.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
ProfilePic.Parent = HomeTab
Instance.new("UICorner", ProfilePic).CornerRadius = UDim.new(1, 0)

local ExecutorName = "Unknown Executor"
if identifyexecutor then
	local success, name = pcall(identifyexecutor)
	if success and name then ExecutorName = name end
end

local Greeting = Instance.new("TextLabel")
Greeting.Size = UDim2.new(1, -100, 0, 50)
Greeting.Position = UDim2.new(0, 95, 0, 20)
Greeting.BackgroundTransparency = 1
Greeting.Text = "Greetings, " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"
Greeting.Font = Enum.Font.GothamBold
Greeting.TextSize = 18
Greeting.TextColor3 = Color3.new(1, 1, 1)
Greeting.TextXAlignment = Enum.TextXAlignment.Left
Greeting.TextYAlignment = Enum.TextYAlignment.Top
Greeting.Parent = HomeTab

local ExecInfo = Instance.new("TextLabel")
ExecInfo.Size = UDim2.new(1, -100, 0, 20)
ExecInfo.Position = UDim2.new(0, 95, 0, 45)
ExecInfo.BackgroundTransparency = 1
ExecInfo.Text = "Executor: " .. ExecutorName
ExecInfo.Font = Enum.Font.GothamMedium
ExecInfo.TextSize = 14
ExecInfo.TextColor3 = ACCENT_COLOR
ExecInfo.TextXAlignment = Enum.TextXAlignment.Left
ExecInfo.TextYAlignment = Enum.TextYAlignment.Top
ExecInfo.Parent = HomeTab

local FpsPingContainer = Instance.new("Frame")
FpsPingContainer.Size = UDim2.new(1, -20, 0, 60)
FpsPingContainer.Position = UDim2.new(0, 10, 0, 90)
FpsPingContainer.BackgroundTransparency = 1
FpsPingContainer.Parent = HomeTab

local FpsCard = Instance.new("Frame")
FpsCard.Size = UDim2.new(0.5, -5, 1, 0)
FpsCard.Position = UDim2.new(0, 0, 0, 0)
FpsCard.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FpsCard.BackgroundTransparency = 0.5
FpsCard.Parent = FpsPingContainer
Instance.new("UICorner", FpsCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", FpsCard).Color = Color3.fromRGB(40, 40, 50)

local FpsLabel = Instance.new("TextLabel")
FpsLabel.Size = UDim2.new(1, 0, 1, 0)
FpsLabel.BackgroundTransparency = 1
FpsLabel.Text = "FPS: ..."
FpsLabel.Font = Enum.Font.GothamBold
FpsLabel.TextSize = 16
FpsLabel.TextColor3 = Color3.new(1, 1, 1)
FpsLabel.Parent = FpsCard

local PingCard = Instance.new("Frame")
PingCard.Size = UDim2.new(0.5, -5, 1, 0)
PingCard.Position = UDim2.new(0.5, 5, 0, 0)
PingCard.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
PingCard.BackgroundTransparency = 0.5
PingCard.Parent = FpsPingContainer
Instance.new("UICorner", PingCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", PingCard).Color = Color3.fromRGB(40, 40, 50)

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(1, 0, 1, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Ping: ..."
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 16
PingLabel.TextColor3 = Color3.new(1, 1, 1)
PingLabel.Parent = PingCard

task.spawn(function()
	local lastTime = tick()
	local frames = 0
	RunService.RenderStepped:Connect(function()
		frames = frames + 1
		local currentTime = tick()
		if currentTime - lastTime >= 1 then
			FpsLabel.Text = "FPS: " .. frames
			frames = 0
			lastTime = currentTime
			
			local success, ping = pcall(function() return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
			if success then
				PingLabel.Text = "Ping: " .. ping .. "ms"
			end
		end
	end)
end)

-- Game Info Card
local GameInfoCard = Instance.new("Frame")
GameInfoCard.Size = UDim2.new(1, -20, 0, 70)
GameInfoCard.Position = UDim2.new(0, 10, 0, 160)
GameInfoCard.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
GameInfoCard.BackgroundTransparency = 0.5
GameInfoCard.Parent = HomeTab
Instance.new("UICorner", GameInfoCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", GameInfoCard).Color = Color3.fromRGB(40, 40, 50)

local GameIcon = Instance.new("ImageLabel")
GameIcon.Size = UDim2.new(0, 50, 0, 50)
GameIcon.Position = UDim2.new(0, 10, 0, 10)
GameIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
GameIcon.BackgroundTransparency = 0
GameIcon.Parent = GameInfoCard
Instance.new("UICorner", GameIcon).CornerRadius = UDim.new(0, 6)

local GameTitle = Instance.new("TextLabel")
GameTitle.Size = UDim2.new(1, -80, 0, 30)
GameTitle.Position = UDim2.new(0, 70, 0, 10)
GameTitle.BackgroundTransparency = 1
GameTitle.Text = "Loading Game Info..."
GameTitle.Font = Enum.Font.GothamBold
GameTitle.TextSize = 16
GameTitle.TextColor3 = Color3.new(1, 1, 1)
GameTitle.TextXAlignment = Enum.TextXAlignment.Left
GameTitle.TextYAlignment = Enum.TextYAlignment.Center
GameTitle.TextWrapped = true
GameTitle.Parent = GameInfoCard

local GameIdLabel = Instance.new("TextLabel")
GameIdLabel.Size = UDim2.new(1, -80, 0, 20)
GameIdLabel.Position = UDim2.new(0, 70, 0, 40)
GameIdLabel.BackgroundTransparency = 1
GameIdLabel.Text = "Place ID: " .. game.PlaceId
GameIdLabel.Font = Enum.Font.GothamMedium
GameIdLabel.TextSize = 12
GameIdLabel.TextColor3 = ACCENT_COLOR
GameIdLabel.TextXAlignment = Enum.TextXAlignment.Left
GameIdLabel.TextYAlignment = Enum.TextYAlignment.Top
GameIdLabel.Parent = GameInfoCard

-- Fetch Game Info Async
task.spawn(function()
	local success, info = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId)
	end)
	if success and info then
		GameTitle.Text = info.Name
		GameIcon.Image = "rbxassetid://" .. info.IconImageAssetId
	else
		GameTitle.Text = "Unknown Game"
		GameIcon.Image = "rbxthumb://type=Asset&id=" .. game.PlaceId .. "&w=150&h=150"
	end
end)


local QuickActionsCard = Instance.new("Frame")
QuickActionsCard.Size = UDim2.new(1, -20, 0, 70)
QuickActionsCard.Position = UDim2.new(0, 10, 0, 240)
QuickActionsCard.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
QuickActionsCard.BackgroundTransparency = 0.5
QuickActionsCard.Parent = HomeTab
Instance.new("UICorner", QuickActionsCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", QuickActionsCard).Color = Color3.fromRGB(40, 40, 50)

local InfYieldBtn = Instance.new("TextButton")
InfYieldBtn.Size = UDim2.new(0, 130, 0, 36)
InfYieldBtn.Position = UDim2.new(0, 15, 0.5, -18)
InfYieldBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
InfYieldBtn.Text = "Infinite Yield"
InfYieldBtn.Font = Enum.Font.GothamBold
InfYieldBtn.TextColor3 = ACCENT_COLOR
InfYieldBtn.Parent = QuickActionsCard
Instance.new("UICorner", InfYieldBtn).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", InfYieldBtn).Color = ACCENT_COLOR

InfYieldBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- ==========================================
-- [[ EXECUTOR TAB ]]
-- ==========================================
local CodeBox = Instance.new("ScrollingFrame")
CodeBox.Size = UDim2.new(1, -10, 1, -55)
CodeBox.Position = UDim2.new(0, 5, 0, 0)
CodeBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
CodeBox.BackgroundTransparency = 0.3
CodeBox.BorderSizePixel = 0
CodeBox.ScrollBarThickness = 4
CodeBox.Parent = ExecutorTab
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", CodeBox).Color = Color3.fromRGB(40, 40, 50)

local LineNumbers = Instance.new("TextLabel")
LineNumbers.Size = UDim2.new(0, 30, 1, -10)
LineNumbers.Position = UDim2.new(0, 5, 0, 5)
LineNumbers.BackgroundTransparency = 1
LineNumbers.Font = Enum.Font.Code
LineNumbers.TextSize = 14
LineNumbers.TextColor3 = Color3.fromRGB(100, 100, 120)
LineNumbers.TextXAlignment = Enum.TextXAlignment.Right
LineNumbers.TextYAlignment = Enum.TextYAlignment.Top
LineNumbers.Text = "1\n2"
LineNumbers.ZIndex = 2
LineNumbers.Parent = CodeBox

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(1, -45, 1, -10)
Editor.Position = UDim2.new(0, 40, 0, 5)
Editor.MultiLine = true
Editor.Text = "-- Welcome to Aurora V3\nprint('Hello World')"
Editor.Font = Enum.Font.Code
Editor.TextSize = 14
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.BackgroundTransparency = 1
Editor.ClearTextOnFocus = false
Editor.TextTransparency = 1 
Editor.ZIndex = 10
Editor.Parent = CodeBox

local Highlighter = Instance.new("TextLabel")
Highlighter.Size = UDim2.new(1, 0, 1, 0)
Highlighter.BackgroundTransparency = 1
Highlighter.Font = Enum.Font.Code
Highlighter.TextSize = 14
Highlighter.TextXAlignment = Enum.TextXAlignment.Left
Highlighter.TextYAlignment = Enum.TextYAlignment.Top
Highlighter.RichText = true 
Highlighter.ZIndex = 1
Highlighter.Parent = Editor

local function UpdateSyntax()
	local text = Editor.Text
	
	-- Update line numbers
	local _, count = text:gsub("\n", "\n")
	local lines = ""
	for i = 1, count + 1 do
		lines = lines .. i .. "\n"
	end
	LineNumbers.Text = lines
	
	text = text:gsub("<", "&lt;"):gsub(">", "&gt;")
	local keywords = {"local", "function", "if", "then", "end", "else", "elseif", "for", "in", "do", "while", "return", "true", "false", "nil", "and", "or", "not"}
	local globals = {"game", "workspace", "script", "math", "string", "table", "Color3", "UDim2", "Vector3", "Instance", "pcall", "warn", "print", "require"}
	
	for _, kw in ipairs(keywords) do text = text:gsub("%f[%w_]"..kw.."%f[^%w_]", '<font color="#f86d7c">'..kw..'</font>') end
	for _, gb in ipairs(globals) do text = text:gsub("%f[%w_]"..gb.."%f[^%w_]", '<font color="#84d6f7">'..gb..'</font>') end
	
	text = text:gsub("('.*')", '<font color="#a5d6a7">%1</font>')
	text = text:gsub('(".*")', '<font color="#a5d6a7">%1</font>')
	text = text:gsub("(%-%-[^\n]*)", '<font color="#75715e">%1</font>')
	Highlighter.Text = text
end

Editor:GetPropertyChangedSignal("Text"):Connect(UpdateSyntax)
UpdateSyntax()

-- Executor Buttons
local function createExecBtn(text, pos, color, txtColor)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 100, 0, 38)
	btn.Position = UDim2.new(0, pos, 1, -45)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = txtColor
	btn.Parent = ExecutorTab
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local ExecuteBtn = createExecBtn("EXECUTE", 5, ACCENT_COLOR, Color3.fromRGB(10, 10, 15))
local ClearBtn = createExecBtn("CLEAR", 115, Color3.fromRGB(25, 25, 30), Color3.new(1,1,1))

ExecuteBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function() loadstring(Editor.Text)() end)
	if not success then warn("Aurora Error: " .. err) end
end)
ClearBtn.MouseButton1Click:Connect(function() Editor.Text = "" end)

-- ==========================================
-- [[ SCRIPT HUB TAB ]]
-- ==========================================
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -10, 0, 40)
SearchBar.Position = UDim2.new(0, 5, 0, 0)
SearchBar.PlaceholderText = "Search Scriptblox..."
SearchBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SearchBar.TextColor3 = Color3.new(1,1,1)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.Parent = HubTab
Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", SearchBar).Color = Color3.fromRGB(40, 40, 50)

local HubList = Instance.new("ScrollingFrame")
HubList.Size = UDim2.new(1, -10, 1, -95) -- Adjusted for pagination controls
HubList.Position = UDim2.new(0, 5, 0, 50)
HubList.BackgroundTransparency = 1
HubList.ScrollBarThickness = 4
HubList.Parent = HubTab
Instance.new("UIListLayout", HubList).Padding = UDim.new(0, 8)

-- Pagination Controls
local PageControls = Instance.new("Frame")
PageControls.Size = UDim2.new(1, -10, 0, 35)
PageControls.Position = UDim2.new(0, 5, 1, -40)
PageControls.BackgroundTransparency = 1
PageControls.Parent = HubTab

local PrevBtn = Instance.new("TextButton")
PrevBtn.Size = UDim2.new(0, 80, 1, 0)
PrevBtn.Position = UDim2.new(0, 0, 0, 0)
PrevBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
PrevBtn.Text = "PREV"
PrevBtn.Font = Enum.Font.GothamBold
PrevBtn.TextColor3 = Color3.new(1,1,1)
PrevBtn.Parent = PageControls
Instance.new("UICorner", PrevBtn).CornerRadius = UDim.new(0, 6)

local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0, 80, 1, 0)
NextBtn.Position = UDim2.new(1, -80, 0, 0)
NextBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
NextBtn.Text = "NEXT"
NextBtn.Font = Enum.Font.GothamBold
NextBtn.TextColor3 = Color3.new(1,1,1)
NextBtn.Parent = PageControls
Instance.new("UICorner", NextBtn).CornerRadius = UDim.new(0, 6)

local PageLabel = Instance.new("TextLabel")
PageLabel.Size = UDim2.new(1, -170, 1, 0)
PageLabel.Position = UDim2.new(0, 85, 0, 0)
PageLabel.BackgroundTransparency = 1
PageLabel.Text = "Page 1 of 1"
PageLabel.Font = Enum.Font.GothamMedium
PageLabel.TextColor3 = Color3.new(1,1,1)
PageLabel.TextSize = 14
PageLabel.Parent = PageControls

local CurrentPage = 1
local MaxPages = 1
local CurrentQuery = ""

local function LoadPage(query, page)
	for _, v in pairs(HubList:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
	local success, result = pcall(function() return game:HttpGet(string.format(PROXY_URL, HttpService:UrlEncode(query), page)) end)
	
	if success then
		local data = HttpService:JSONDecode(result)
		if data.result and data.result.scripts then
			-- Calculate total pages based on max=10
			MaxPages = math.max(1, data.result.totalPages or 1) 
			CurrentPage = page
			PageLabel.Text = "Page " .. CurrentPage .. " of " .. MaxPages
			
			for _, scriptData in pairs(data.result.scripts) do
				local Card = Instance.new("Frame")
				Card.Size = UDim2.new(1, -10, 0, 55)
				Card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
				Card.Parent = HubList
				Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)
				
				local Name = Instance.new("TextLabel")
				Name.Text = scriptData.title
				Name.Font = Enum.Font.GothamMedium
				Name.TextSize = 14
				Name.Size = UDim2.new(0.7, 0, 1, 0)
				Name.Position = UDim2.new(0, 15, 0, 0)
				Name.BackgroundTransparency = 1
				Name.TextColor3 = Color3.new(1,1,1)
				Name.TextXAlignment = Enum.TextXAlignment.Left
				Name.Parent = Card
				
				local Load = Instance.new("TextButton")
				Load.Text = "LOAD"
				Load.Font = Enum.Font.GothamBold
				Load.Size = UDim2.new(0, 70, 0, 35)
				Load.Position = UDim2.new(1, -85, 0.5, -17.5)
				Load.BackgroundColor3 = ACCENT_COLOR
				Load.TextColor3 = Color3.fromRGB(10, 10, 15)
				Load.Parent = Card
				Instance.new("UICorner", Load).CornerRadius = UDim.new(0, 6)
				Load.MouseButton1Click:Connect(function() 
					currentScriptToLoad = scriptData.script
					LoadModal.Visible = true 
				end)
			end
			HubList.CanvasSize = UDim2.new(0, 0, 0, #data.result.scripts * 63)
		end
	end
end

SearchBar.FocusLost:Connect(function(enter)
	if not enter then return end
	CurrentQuery = SearchBar.Text
	CurrentPage = 1
	LoadPage(CurrentQuery, CurrentPage)
end)

PrevBtn.MouseButton1Click:Connect(function()
	if CurrentPage > 1 then
		LoadPage(CurrentQuery, CurrentPage - 1)
	end
end)

NextBtn.MouseButton1Click:Connect(function()
	if CurrentPage < MaxPages then
		LoadPage(CurrentQuery, CurrentPage + 1)
	end
end)

-- ==========================================
-- [[ COLLECTION TAB ]]
-- ==========================================
local UploadBtn = Instance.new("TextButton")
UploadBtn.Size = UDim2.new(1, -10, 0, 40)
UploadBtn.Position = UDim2.new(0, 5, 0, 0)
UploadBtn.BackgroundColor3 = ACCENT_COLOR
UploadBtn.Text = "UPLOAD SCRIPT"
UploadBtn.Font = Enum.Font.GothamBold
UploadBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
UploadBtn.Parent = CollectionTab
Instance.new("UICorner", UploadBtn).CornerRadius = UDim.new(0, 6)

-- Collection Modal
local CollectionModal = Instance.new("Frame")
CollectionModal.Size = UDim2.new(1, 0, 1, 0)
CollectionModal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CollectionModal.BackgroundTransparency = 0.5
CollectionModal.ZIndex = 100
CollectionModal.Visible = false
CollectionModal.Parent = Main

local ColModalCard = Instance.new("Frame")
ColModalCard.Size = UDim2.new(0, 300, 0, 250)
ColModalCard.Position = UDim2.new(0.5, -150, 0.5, -125)
ColModalCard.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ColModalCard.ZIndex = 101
ColModalCard.Parent = CollectionModal
Instance.new("UICorner", ColModalCard).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", ColModalCard).Color = Color3.fromRGB(40, 40, 50)

local ColModalTitle = Instance.new("TextLabel")
ColModalTitle.Size = UDim2.new(1, 0, 0, 40)
ColModalTitle.BackgroundTransparency = 1
ColModalTitle.Text = "Upload Script"
ColModalTitle.Font = Enum.Font.GothamBold
ColModalTitle.TextSize = 16
ColModalTitle.TextColor3 = Color3.new(1, 1, 1)
ColModalTitle.ZIndex = 102
ColModalTitle.Parent = ColModalCard

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(1, -40, 0, 35)
NameInput.Position = UDim2.new(0, 20, 0, 50)
NameInput.PlaceholderText = "Name Script"
NameInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
NameInput.TextColor3 = Color3.new(1,1,1)
NameInput.Font = Enum.Font.Gotham
NameInput.TextSize = 14
NameInput.ZIndex = 102
NameInput.Parent = ColModalCard
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", NameInput).Color = Color3.fromRGB(40, 40, 50)

local ScriptContentInput = Instance.new("TextBox")
ScriptContentInput.Size = UDim2.new(1, -40, 0, 80)
ScriptContentInput.Position = UDim2.new(0, 20, 0, 95)
ScriptContentInput.PlaceholderText = "Script Content"
ScriptContentInput.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ScriptContentInput.TextColor3 = Color3.new(1,1,1)
ScriptContentInput.Font = Enum.Font.Gotham
ScriptContentInput.TextSize = 14
ScriptContentInput.TextYAlignment = Enum.TextYAlignment.Top
ScriptContentInput.TextXAlignment = Enum.TextXAlignment.Left
ScriptContentInput.MultiLine = true
ScriptContentInput.ClearTextOnFocus = false
ScriptContentInput.ZIndex = 102
ScriptContentInput.Parent = ColModalCard
Instance.new("UICorner", ScriptContentInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", ScriptContentInput).Color = Color3.fromRGB(40, 40, 50)

local ColUploadBtn = Instance.new("TextButton")
ColUploadBtn.Size = UDim2.new(0.5, -25, 0, 35)
ColUploadBtn.Position = UDim2.new(0, 20, 0, 190)
ColUploadBtn.BackgroundColor3 = ACCENT_COLOR
ColUploadBtn.Text = "UPLOAD"
ColUploadBtn.Font = Enum.Font.GothamBold
ColUploadBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
ColUploadBtn.ZIndex = 102
ColUploadBtn.Parent = ColModalCard
Instance.new("UICorner", ColUploadBtn).CornerRadius = UDim.new(0, 6)

local ColCancelBtn = Instance.new("TextButton")
ColCancelBtn.Size = UDim2.new(0.5, -25, 0, 35)
ColCancelBtn.Position = UDim2.new(0.5, 5, 0, 190)
ColCancelBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ColCancelBtn.Text = "CANCEL"
ColCancelBtn.Font = Enum.Font.GothamBold
ColCancelBtn.TextColor3 = Color3.new(1, 1, 1)
ColCancelBtn.ZIndex = 102
ColCancelBtn.Parent = ColModalCard
Instance.new("UICorner", ColCancelBtn).CornerRadius = UDim.new(0, 6)

UploadBtn.MouseButton1Click:Connect(function()
	CollectionModal.Visible = true
	NameInput.Text = ""
	ScriptContentInput.Text = ""
	ColModalTitle.Text = "Upload Script"
end)

ColCancelBtn.MouseButton1Click:Connect(function()
	CollectionModal.Visible = false
end)

local CollectionList = Instance.new("ScrollingFrame")
CollectionList.Size = UDim2.new(1, -10, 1, -50)
CollectionList.Position = UDim2.new(0, 5, 0, 50)
CollectionList.BackgroundTransparency = 1
CollectionList.ScrollBarThickness = 4
CollectionList.Parent = CollectionTab
local ColListLayout = Instance.new("UIListLayout")
ColListLayout.Padding = UDim.new(0, 8)
ColListLayout.Parent = CollectionList

local function RefreshCollection()
	for _, v in pairs(CollectionList:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
	
	local files = {}
	if hasFileSystem then
		local success, result = pcall(function() return listfiles("AuroraScripts") end)
		if success then files = result end
	else
		for name, content in pairs(SessionScripts) do table.insert(files, name) end
	end
	
	for i, filePath in pairs(files) do
		local fileName = filePath:match("([^/\\]+)$") or filePath
		local Card = Instance.new("Frame")
		Card.Size = UDim2.new(1, -10, 0, 50)
		Card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
		Card.Parent = CollectionList
		Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)
		
		local NameLabel = Instance.new("TextLabel")
		NameLabel.Text = fileName
		NameLabel.Font = Enum.Font.GothamMedium
		NameLabel.TextSize = 14
		NameLabel.Size = UDim2.new(0.7, 0, 1, 0)
		NameLabel.Position = UDim2.new(0, 15, 0, 0)
		NameLabel.BackgroundTransparency = 1
		NameLabel.TextColor3 = Color3.new(1,1,1)
		NameLabel.TextXAlignment = Enum.TextXAlignment.Left
		NameLabel.Parent = Card
		
		local LoadBtn = Instance.new("TextButton")
		LoadBtn.Text = "LOAD"
		LoadBtn.Font = Enum.Font.GothamBold
		LoadBtn.Size = UDim2.new(0, 70, 0, 30)
		LoadBtn.Position = UDim2.new(1, -85, 0.5, -15)
		LoadBtn.BackgroundColor3 = ACCENT_COLOR
		LoadBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
		LoadBtn.Parent = Card
		Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 6)
		
		LoadBtn.MouseButton1Click:Connect(function()
			local content = ""
			if hasFileSystem then
				local success, result = pcall(function() return readfile(filePath) end)
				if success then content = result end
			else
				content = SessionScripts[fileName] or "-- Error loading script"
			end
			currentScriptToLoad = content
			LoadModal.Visible = true
		end)
	end
	CollectionList.CanvasSize = UDim2.new(0, 0, 0, #files * 58)
end

ColUploadBtn.MouseButton1Click:Connect(function()
	local name = NameInput.Text
	local content = ScriptContentInput.Text
	
	if name == "" or content == "" then
		ColModalTitle.Text = "Please fill required fields"
		return
	end
	
	if not name:match("%.txt$") and not name:match("%.lua$") then name = name .. ".lua" end
	
	if hasFileSystem then
		pcall(function() writefile("AuroraScripts/" .. name, content) end)
	else
		SessionScripts[name] = content
	end
	
	CollectionModal.Visible = false
	RefreshCollection()
end)

-- ==========================================
-- [[ CONSOLE TAB ]]
-- ==========================================
local ConsoleList = Instance.new("ScrollingFrame")
ConsoleList.Size = UDim2.new(1, -10, 1, -10)
ConsoleList.Position = UDim2.new(0, 5, 0, 5)
ConsoleList.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
ConsoleList.BorderSizePixel = 0
ConsoleList.ScrollBarThickness = 6
ConsoleList.Parent = ConsoleTab
Instance.new("UICorner", ConsoleList).CornerRadius = UDim.new(0, 6)

local ConsoleLayout = Instance.new("UIListLayout")
ConsoleLayout.Padding = UDim.new(0, 2)
ConsoleLayout.Parent = ConsoleList

local function AddConsoleMessage(message, messageType)
	local MsgLabel = Instance.new("TextLabel")
	MsgLabel.Text = "  " .. message
	MsgLabel.Font = Enum.Font.Code
	MsgLabel.TextSize = 13
	MsgLabel.Size = UDim2.new(1, 0, 0, 20)
	MsgLabel.BackgroundTransparency = 1
	MsgLabel.TextXAlignment = Enum.TextXAlignment.Left
	MsgLabel.TextWrapped = true
	
	-- Auto-size height based on text length
	local bounds = game:GetService("TextService"):GetTextSize(MsgLabel.Text, 13, Enum.Font.Code, Vector2.new(ConsoleList.AbsoluteSize.X - 20, math.huge))
	MsgLabel.Size = UDim2.new(1, -10, 0, math.max(20, bounds.Y + 4))

	if messageType == Enum.MessageType.MessageOutput or messageType == Enum.MessageType.MessageInfo then
		MsgLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	elseif messageType == Enum.MessageType.MessageWarning then
		MsgLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
	elseif messageType == Enum.MessageType.MessageError then
		MsgLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
	end
	
	MsgLabel.Parent = ConsoleList
	ConsoleList.CanvasSize = UDim2.new(0, 0, 0, ConsoleLayout.AbsoluteContentSize.Y)
	ConsoleList.CanvasPosition = Vector2.new(0, ConsoleList.CanvasSize.Y.Offset) -- Auto-scroll
end

LogService.MessageOut:Connect(AddConsoleMessage)
for _, log in ipairs(LogService:GetLogHistory()) do
	AddConsoleMessage(log.message, log.messageType)
end

-- ==========================================
-- [[ SETTINGS TAB ]]
-- ==========================================
local SettingsList = Instance.new("ScrollingFrame")
SettingsList.Size = UDim2.new(1, -10, 1, -10)
SettingsList.Position = UDim2.new(0, 5, 0, 5)
SettingsList.BackgroundTransparency = 1
SettingsList.ScrollBarThickness = 4
SettingsList.Parent = SettingsTab

local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.Padding = UDim.new(0, 8)
SettingsLayout.Parent = SettingsList

-- FPS Cap Dropdown (Button Cycle)
local FpsCapCard = Instance.new("Frame")
FpsCapCard.Size = UDim2.new(1, -10, 0, 50)
FpsCapCard.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
FpsCapCard.Parent = SettingsList
Instance.new("UICorner", FpsCapCard).CornerRadius = UDim.new(0, 6)

local FpsCapLabel = Instance.new("TextLabel")
FpsCapLabel.Size = UDim2.new(0.5, 0, 1, 0)
FpsCapLabel.Position = UDim2.new(0, 15, 0, 0)
FpsCapLabel.BackgroundTransparency = 1
FpsCapLabel.Text = "Set FPS Cap"
FpsCapLabel.Font = Enum.Font.GothamMedium
FpsCapLabel.TextSize = 14
FpsCapLabel.TextColor3 = Color3.new(1, 1, 1)
FpsCapLabel.TextXAlignment = Enum.TextXAlignment.Left
FpsCapLabel.Parent = FpsCapCard

local FpsCapBtn = Instance.new("TextButton")
FpsCapBtn.Size = UDim2.new(0, 100, 0, 30)
FpsCapBtn.Position = UDim2.new(1, -115, 0.5, -15)
FpsCapBtn.BackgroundColor3 = ACCENT_COLOR
FpsCapBtn.Text = "60"
FpsCapBtn.Font = Enum.Font.GothamBold
FpsCapBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
FpsCapBtn.Parent = FpsCapCard
Instance.new("UICorner", FpsCapBtn).CornerRadius = UDim.new(0, 6)

local fpsCaps = {60, 80, 120, 144, 240, 9999}
local currentFpsIndex = 1

FpsCapBtn.MouseButton1Click:Connect(function()
	currentFpsIndex = currentFpsIndex + 1
	if currentFpsIndex > #fpsCaps then
		currentFpsIndex = 1
	end
	
	local cap = fpsCaps[currentFpsIndex]
	if cap == 9999 then
		FpsCapBtn.Text = "Uncapped"
	else
		FpsCapBtn.Text = tostring(cap)
	end
	
	if setfpscap then
		pcall(function() setfpscap(cap) end)
	end
end)

-- Verify Teleport Toggle
local VerifyTeleportCard = Instance.new("Frame")
VerifyTeleportCard.Size = UDim2.new(1, -10, 0, 50)
VerifyTeleportCard.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
VerifyTeleportCard.Parent = SettingsList
Instance.new("UICorner", VerifyTeleportCard).CornerRadius = UDim.new(0, 6)

local VerifyTeleportLabel = Instance.new("TextLabel")
VerifyTeleportLabel.Size = UDim2.new(0.5, 0, 1, 0)
VerifyTeleportLabel.Position = UDim2.new(0, 15, 0, 0)
VerifyTeleportLabel.BackgroundTransparency = 1
VerifyTeleportLabel.Text = "Verify Teleport"
VerifyTeleportLabel.Font = Enum.Font.GothamMedium
VerifyTeleportLabel.TextSize = 14
VerifyTeleportLabel.TextColor3 = Color3.new(1, 1, 1)
VerifyTeleportLabel.TextXAlignment = Enum.TextXAlignment.Left
VerifyTeleportLabel.Parent = VerifyTeleportCard

local VerifyTeleportToggle = Instance.new("TextButton")
VerifyTeleportToggle.Size = UDim2.new(0, 50, 0, 24)
VerifyTeleportToggle.Position = UDim2.new(1, -65, 0.5, -12)
VerifyTeleportToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
VerifyTeleportToggle.Text = ""
VerifyTeleportToggle.Parent = VerifyTeleportCard
Instance.new("UICorner", VerifyTeleportToggle).CornerRadius = UDim.new(1, 0)

local VerifyTeleportIndicator = Instance.new("Frame")
VerifyTeleportIndicator.Size = UDim2.new(0, 20, 0, 20)
VerifyTeleportIndicator.Position = UDim2.new(0, 2, 0.5, -10)
VerifyTeleportIndicator.BackgroundColor3 = Color3.new(1, 1, 1)
VerifyTeleportIndicator.Parent = VerifyTeleportToggle
Instance.new("UICorner", VerifyTeleportIndicator).CornerRadius = UDim.new(1, 0)

local AntiTeleportEnabled = false

VerifyTeleportToggle.MouseButton1Click:Connect(function()
	AntiTeleportEnabled = not AntiTeleportEnabled
	if AntiTeleportEnabled then
		VerifyTeleportToggle.BackgroundColor3 = ACCENT_COLOR
		TweenService:Create(VerifyTeleportIndicator, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
	else
		VerifyTeleportToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		TweenService:Create(VerifyTeleportIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
	end
end)

if hookmetamethod then
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		local method = getnamecallmethod()
		if AntiTeleportEnabled and (method == "Teleport" or method == "TeleportToPlaceInstance" or method == "TeleportAsync") then
			print("Aurora: Blocked forced teleport attempt.")
			return
		end
		return oldNamecall(self, ...)
	end)
end

SettingsList.CanvasSize = UDim2.new(0, 0, 0, SettingsLayout.AbsoluteContentSize.Y)

-- ==========================================
-- [[ NAVIGATION & UI LOGIC ]]
-- ==========================================
local tabs = {
	Home = HomeTab,
	Executor = ExecutorTab,
	Hub = HubTab,
	Collection = CollectionTab,
	Console = ConsoleTab,
	Settings = SettingsTab
}

local currentTab = HomeTab

local function SwitchTab(tabName)
	if tabs[tabName] == currentTab then return end
	
	local oldTab = currentTab
	local newTab = tabs[tabName]
	currentTab = newTab
	
	-- Fade out old tab
	local fadeOut = TweenService:Create(oldTab, TweenInfo.new(0.2), {GroupTransparency = 1})
	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		oldTab.Visible = false
		newTab.Visible = true
		newTab.GroupTransparency = 1
		-- Fade in new tab
		TweenService:Create(newTab, TweenInfo.new(0.2), {GroupTransparency = 0}):Play()
	end)

	if tabName == "Collection" then RefreshCollection() end
end

local function createNavBtn(text, pos, targetTab)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.9, 0, 0, 36)
	b.Position = UDim2.new(0.05, 0, 0, pos)
	b.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	b.BackgroundTransparency = 0.5
	b.Text = text
	b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 13
	b.Parent = Sidebar
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	b.MouseButton1Click:Connect(function() SwitchTab(targetTab) end)
end

createNavBtn("Home", 70, "Home")
createNavBtn("Executor", 115, "Executor")
createNavBtn("Collection", 160, "Collection")
createNavBtn("Script Hub", 205, "Hub")
createNavBtn("Console", 250, "Console")
createNavBtn("Settings", 295, "Settings")

-- [[ MOBILE DRAGGING ]]
local function MakeDraggable(gui, isToggleBtn)
	local dragging, dragInput, dragStart, startPos
	local hasMoved = false
	local DRAG_THRESHOLD = 5

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			hasMoved = false
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function() 
				if input.UserInputState == Enum.UserInputState.End then 
					dragging = false 
					if isToggleBtn and not hasMoved then
						Main.Visible = not Main.Visible
					end
				end 
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
			dragInput = input 
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if delta.Magnitude > DRAG_THRESHOLD then
				hasMoved = true
			end
			if hasMoved then
				gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end
	end)
end

MakeDraggable(Main, false)
MakeDraggable(ToggleBtn, true)

LoadExecutorBtn.MouseButton1Click:Connect(function()
	if Editor and SwitchTab then
		Editor.Text = currentScriptToLoad
		LoadModal.Visible = false
		SwitchTab("Executor") -- Switch to executor tab automatically
	end
end)

print("aurora script | v1.1 | ano_jay?!")
