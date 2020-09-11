local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local helpers = require("helpers")

local cpu_widget = helpers.bar_widget(x.color3)
cpu_widget.forced_width = dpi(80)

awesome.connect_signal("demons::cpu", function(value)
    cpu_widget.markup = "Cpu: "..value.."%"
end)

return cpu_widget
