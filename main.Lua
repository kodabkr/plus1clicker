local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kodabkr/hubLoad/main/main.lua"))()
local Koko = library.new("Koko Hub", 5013109572)

local selectedEgg = nil
local wheelInterval = nil
local coreGui = game:GetService("CoreGui")

local FarmSection = Koko:addPage("Farming", 5012544693)
local automation = FarmSection:addSection("automation")

automation:addToggle("Auto Click", nil, function(state)
	auto1 = state
	if auto1 then
		coroutine.wrap(function()
			while auto1 and task.wait() do
				game:GetService("ReplicatedStorage"):WaitForChild("events-shared/network@GlobalEvents"):WaitForChild("placeBlock"):FireServer()
			end
		end)()
	end
end)

automation:addDropdown("Select Egg", { "Grass Egg", "Stone Egg", "Cactus Egg", "Sandstone Egg", "Snowman Egg", "Ice Egg", "Warped Egg", ""}, function(passThrough)
	selectedEgg = passThrough
end)

automation:addToggle("Auto Open Selected Egg", nil, function(state)
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

automation:addToggle("Auto Rebirth", nil, function(state)
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

automation:addButton("Disable Purchase Prompts", function()
	coreGui.PurchasePrompt.Enabled = false
end)

automation:addButton("Enable Purchase Prompts", function()
	coreGui.PurchasePrompt.Enabled = true
end)

automation:addSlider("Wheel Delay (Seconds)", 0.1, 0, 30, function(passThrough)
	wheelInterval = passThrough
end)

automation:addToggle("Auto Spin Wheel", nil, function(state)
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
