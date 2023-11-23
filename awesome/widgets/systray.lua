local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi

local ICONS = "/usr/share/icons/Chicago95/"

local systray_widget = wibox.widget({
	{
		wibox.widget.imagebox(ICONS .. "/apps/48/xfce4-systray.png", true),
		margins = 1,
		layout = wibox.container.margin,
	},
	widget = wibox.container.background,
})

local popup = awful.popup({
	ontop = true,
	visible = false,
	border_width = 2,
	border_color = beautiful.border_focus,
	preferred_positions = "bottom",
	widget = {
		widget = wibox.container.background,
		forced_width = dpi(25),
		forced_height = dpi(75),
		{
			widget = wibox.container.margin,
			margins = 1,
			{
				widget = wibox.widget.systray,
				horizontal = false,
			},
		},
	},
})

local function worker()
	systray_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
		popup.visible = not popup.visible

		if popup.visible then
			systray_widget:set_bg(beautiful.visual_blue)
			popup:move_next_to(mouse.current_widget_geometry)
		else
			systray_widget:set_bg(beautiful.bg_normal)
		end
	end)))

	return systray_widget
end

return worker
