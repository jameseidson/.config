-------------------------------------------------
-- Logout Menu Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/logout-menu-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local ICONS = "/usr/share/icons/Chicago95/"

local logout_menu_widget = wibox.widget({
	{
		wibox.widget.imagebox(ICONS .. "apps/48/screensaver.png", true),
		margins = 1,
		layout = wibox.container.margin,
	},
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end,
	widget = wibox.container.background,
})

local popup = awful.popup({
	ontop = true,
	visible = false,
	shape = function(cr, width, height)
		gears.shape.rectangle(cr, width, height)
	end,
	border_width = 2,
	border_color = beautiful.border_focus,
	maximum_width = 400,
	offset = { y = 5 },
	widget = {},
})

local function worker(user_args)
	local rows = { layout = wibox.layout.fixed.vertical }

	local args = user_args or {}

	local font = args.font or beautiful.font

	local onlogout = args.onlogout or function()
		awful.spawn.with_shell("pkill -9 " .. os.getenv("USER"))
	end
	local onlock = args.onlock or function()
		awful.spawn.with_shell("i3lock")
	end
	local onreboot = args.onreboot or function()
		awful.spawn.with_shell("systemctl reboot")
	end
	local onsuspend = args.onsuspend or function()
		awful.spawn.with_shell("systemctl suspend")
	end
	local onpoweroff = args.onpoweroff or function()
		awful.spawn.with_shell("systemctl poweroff")
	end

	local menu_items = {
		{ name = "Log out", icon = ICONS .. "/apps/48/gnome-logout.png", command = onlogout },
		{ name = "Lock", icon = ICONS .. "/actions/48/system-lock-screen.png", command = onlock },
		{ name = "Reboot", icon = ICONS .. "/actions/48/system-reboot.png", command = onreboot },
		{ name = "Suspend", icon = ICONS .. "/apps/48/sleep.png", command = onsuspend },
		{
			name = "Power off",
			icon = ICONS .. "/devices/48/uninterruptible-power-supply.png",
			command = onpoweroff,
		},
	}

	for _, item in ipairs(menu_items) do
		local row = wibox.widget({
			{
				{
					widget = wibox.widget.imagebox,
					image = item.icon,
					forced_height = 36,
					forced_width = 36,
				},
				{
					text = item.name,
					font = font,
					widget = wibox.widget.textbox,
				},
				spacing = 2,
				layout = wibox.layout.fixed.horizontal,
			},
			bg = beautiful.bg_normal,
			widget = wibox.container.background,
		})

		row:connect_signal("mouse::enter", function(c)
			c:set_bg(beautiful.visual_blue)
			c:set_fg(beautiful.bg_normal)
		end)
		row:connect_signal("mouse::leave", function(c)
			c:set_bg(beautiful.bg_normal)
			c:set_fg(beautiful.fg_normal)
		end)

		local old_cursor, old_wibox
		row:connect_signal("mouse::enter", function()
			local wb = mouse.current_wibox
			old_cursor, old_wibox = wb.cursor, wb
			wb.cursor = "hand1"
		end)
		row:connect_signal("mouse::leave", function()
			if old_wibox then
				old_wibox.cursor = old_cursor
				old_wibox = nil
			end
		end)

		row:buttons(awful.util.table.join(awful.button({}, 1, function()
			popup.visible = not popup.visible
			item.command()
		end)))

		table.insert(rows, row)
	end
	popup:setup(rows)

	logout_menu_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
		if popup.visible then
			popup.visible = not popup.visible
			logout_menu_widget:set_bg("#00000000")
		else
			popup:move_next_to(mouse.current_widget_geometry)
			logout_menu_widget:set_bg(beautiful.visual_blue)
		end
	end)))

	return logout_menu_widget
end

return worker
