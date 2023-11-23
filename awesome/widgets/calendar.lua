local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

return function()
	local widget = wibox.widget.textclock("%a %b%e %I:%M %p")

	widget:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.util.spawn("google-chrome-stable calendar.google.com")
	end)))

	return widget
end
