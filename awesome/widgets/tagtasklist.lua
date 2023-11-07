-- awesomewm fancy_taglist: a taglist that contains a tasklist for each tag.

-- Usage:
-- 1. Save as "fancy_taglist.lua" in ~/.config/awesome
-- 2. Add a fancy_taglist for every screen:
--          awful.screen.connect_for_each_screen(function(s)
--              ...
--              local fancy_taglist = require("fancy_taglist")
--              s.mytaglist = fancy_taglist.new({
--                  screen = s,
--                  taglist_buttons = mytagbuttons,
--                  tasklist_buttons = mytasklistbuttons
--              })
--              ...
--          end)
-- 3. Add s.mytaglist to your wibar.

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local M = {}

local generate_filter = function(t)
	return function(c, _)
		local ctags = c:tags()
		for _, v in ipairs(ctags) do
			if v == t then
				return true
			end
		end
		return false
	end
end

local tasklist = function(cfg, t)
	return awful.widget.tasklist({
		screen = cfg.screen or awful.screen.focused(),
		filter = generate_filter(t),
		buttons = cfg.tasklist_buttons,
		style = {
			bg_focus = beautiful.selected,
			-- shape_border_width_focus = 1,
			-- shape_border_color_focus = beautiful.fg_focus,
			-- shape = gears.shape.rectangle,
		},
		widget_template = {
			id = "background_role",
			widget = wibox.container.background,
			{
				widget = wibox.container.margin,
				margins = 4,
				{
					id = "icon_role",
					widget = wibox.widget.imagebox,
				},
			},
		},
	})
end

function M:new(cfg)
	local s = cfg.screen or awful.screen.focused()
	local taglist_buttons = cfg.taglist_buttons

	return awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		style = {
			shape_border_width = 1,
			shape_border_color = beautiful.border_normal,
			shape_border_color_focus = beautiful.selected,
			bg_focus = beautiful.bg_normal,
			shape = gears.shape.rectangle,
			disable_icon = true,
		},
		widget_template = {
			{
				widget = wibox.container.margin,
				left = 3,
				right = 3,
				{
					id = "background_role",
					widget = wibox.container.background,
					{
						widget = wibox.container.margin,
						left = 10,
						-- right = 10,
						{
							layout = wibox.layout.fixed.horizontal,
							{
								-- tag
								id = "text_role",
								widget = wibox.widget.textbox,
							},
							{
								widget = wibox.container.margin,
								left = 10,
								{
									-- tasklist
									id = "tasklist_placeholder",
									layout = wibox.layout.fixed.horizontal,
								},
							},
						},
					},
				},
			},
			layout = wibox.layout.fixed.horizontal,
			create_callback = function(self, _, index, _)
				local t = s.tags[index]
				self:get_children_by_id("tasklist_placeholder")[1]:add(tasklist(cfg, t))
			end,
		},
		buttons = taglist_buttons,
	})
end

return M
