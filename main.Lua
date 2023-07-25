-- Anti-afk
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
end

-- Libraries
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kodabkr/hubLoad/main/main.lua"))()
local Koko = library.new("Koko Hub | Current Game: " .. gameName .. " |", 5013109572)

-- Variables
local selectedEgg = nil
local wheelInterval = nil
local coreGui = game:GetService("CoreGui")
local codes = {'ihateseals','scorpio','luckyfrog','KUBO'}

-- Ui Gen
local FarmSection = Koko:addPage("Farming", 5012544693)
local farmMain = FarmSection:addSection("Main")

local SettingsSection = Koko:addPage("Settings", 5012544693)
local settings = SettingsSection:addSection("Main")

farmMain:addToggle("Auto Click", nil, function(state)
	auto1 = state
	if auto1 then
		coroutine.wrap(function()
			while auto1 and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("events-shared/network@GlobalEvents"):WaitForChild("placeBlock"):FireServer()
			end
		end)()
	end
end)

farmMain:addDropdown("Select Egg", { "Grass Egg", "Stone Egg", "Cactus Egg", "Sandstone Egg", "Snowman Egg", "Ice Egg", "Warped Egg", ""}, function(passThrough)
	selectedEgg = passThrough
end)

farmMain:addToggle("Auto Open Selected Egg", nil, function(state)
	auto2 = state
	if auto2 then
		coroutine.wrap(function()
			while auto2 and task.wait() do
				local args = {[1] = 0, [2] = tostring(selectedEgg)}
				game:GetService("ReplicatedStorage"):WaitForChild("functions-shared/network@GlobalFunctions"):WaitForChild("s:openEgg"):FireServer(unpack(args))
			end
		end)()
	end
end)

farmMain:addToggle("Auto Rebirth", nil, function(state)
	auto3 = state
	if auto3 then
		coroutine.wrap(function()
			while auto3 and task.wait() do
				local args = {[1] = 0}
				game:GetService("ReplicatedStorage"):WaitForChild("functions-shared/network@GlobalFunctions"):WaitForChild("s:rebirth"):FireServer(unpack(args))				
			end
		end)()
	end
end)

farmMain:addButton("Disable Pop ups", function()
	game:GetService("Players").LocalPlayer.PlayerGui.Notifications.Box.Visible = false
end)

farmMain:addButton("Enable Pop ups", function()
	game:GetService("Players").LocalPlayer.PlayerGui.Notifications.Box.Visible = true
end)

farmMain:addSlider("Wheel Delay (Seconds)", 1, 0, 30, function(passThrough) -- <StartVal> / <MinVal> / <MaxVal>
	wheelInterval = passThrough
end)

farmMain:addToggle("Auto Spin Wheel", nil, function(state)
	auto4 = state
	if auto4 then
		coroutine.wrap(function()
			while auto4 and task.wait(wheelInterval) do
				local args = {[1] = 4}
				game:GetService("ReplicatedStorage"):WaitForChild("functions-shared/network@GlobalFunctions"):WaitForChild("s:spin"):FireServer(unpack(args))				
			end
		end)()
	end
end)

farmMain:addButton("Claim All Codes", function()
	for _,v in pairs(codes) do
		local args = {[1] = 0, [2] = v}
		game:GetService("ReplicatedStorage"):WaitForChild("functions-shared/network@GlobalFunctions"):WaitForChild("s:redeemCode"):FireServer(unpack(args))
	end		
end)

settings:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
	Koko:toggle()
end, function()
	Notification.new("info", "Keybind Update", "You changed your keybind!", true, 5)
end)

settings:addButton("Disable Purchase Prompts", function()
	coreGui.PurchasePrompt.Enabled = false
end)

settings:addButton("Enable Purchase Prompts", function()
	coreGui.PurchasePrompt.Enabled = true
end)

Koko:SelectPage(venyx.pages[1], true)
