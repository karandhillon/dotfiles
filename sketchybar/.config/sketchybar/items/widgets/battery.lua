local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	icon = {
		string = icons.battery._100,
		color = colors.accent.gold,
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 13.0,
		},
		width = 42,
	},
	padding_right = 1,
	padding_left = 1,
	update_freq = 30,
})

local function battery_update()
	sbar.exec("pmset -g batt", function(result)
		local percent = tonumber(string.match(result, "(%d+)%%")) or 0
		local charging = string.find(result, "AC Power") ~= nil

		local icon = icons.battery._0
		if charging then
			icon = icons.battery.charging
		elseif percent > 75 then
			icon = icons.battery._100
		elseif percent > 50 then
			icon = icons.battery._75
		elseif percent > 25 then
			icon = icons.battery._50
		elseif percent > 10 then
			icon = icons.battery._25
		end

		local color = colors.accent.gold
		if percent < 10 then
			color = colors.semantic.error
		elseif percent < 30 then
			color = colors.semantic.warn
		elseif charging then
			color = colors.accent.sage
		end

		battery:set({
			icon = { string = icon, color = color },
			label = { string = percent .. "%", color = color },
		})
	end)
end

battery:subscribe({ "routine", "forced", "system_woke", "power_source_change" }, battery_update)

battery:subscribe("mouse.clicked", function(env)
	sbar.exec("open \"x-apple.systempreferences:com.apple.Battery-Settings\"")
end)

sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
	background = { color = colors.bar.bg },
})

sbar.add("item", "widgets.battery.padding", {
	position = "right",
	width = settings.group_paddings,
})
