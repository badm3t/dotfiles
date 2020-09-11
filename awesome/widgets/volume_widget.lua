local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local GET_VOLUME_CMD = 'amixer get Master'
local INC_VOLUME_CMD = 'amixer set Master 2%+'
local DEC_VOLUME_CMD = 'amixer set Master 2%-'
local TOG_VOLUME_CMD = 'amixer set Master toggle'

local volume = helpers.bar_widget(x.color3)
volume.mute = 0
volume.value = 100

volume.last = {}

volume:connect_signal("button::press", function(_, _, _, button)
  if button == 4 then
    awful.spawn.easy_async({ "bash", "-c", INC_VOLUME_CMD}, function() end)
  elseif button == 5 then
    awful.spawn.easy_async({ "bash", "-c", DEC_VOLUME_CMD}, function() end)
  end
end)
--""
--""
--
--
--
--
--
--
--
--
--

local icons = { on = "", off = "" }
local volume_icon = helpers.create_button(icons.on, x.color9, x.color9, _, _)
volume_icon.forced_width = dpi(25)

local function toggle_mute()
  awful.spawn.easy_async({ "bash", "-c", TOG_VOLUME_CMD }, function() end)
end

local function toggle_icon_volume(volume)
  if volume.mute == 0 then
    volume_icon.symbol = icons.off
    volume.mute = 1
    toggle_mute()
  else
    volume_icon.symbol = icons.on
    volume.mute = 0
    toggle_mute()
  end
end

volume_icon:buttons(
  awful.button({}, awful.button.names.LEFT, function()
    toggle_icon_volume(volume)
  end)
)

local function update()
  awful.spawn.easy_async({ "bash", "-c", GET_VOLUME_CMD },
    function(stdout, stderr, reason, exit_code)
      local lvl, status = string.match(stdout, "([%d]+)%%.*%[([%l]*)")
      if volume.last.lvl ~= lvl or volume.last.status ~= status then
        volume_now = { lvl = lvl, status = status }
        volume.value = lvl
        volume.last = volume_now
        volume.markup = lvl.."%"
      end
    end)
end

helpers.widget_timer(update)

local volume_widget = wibox.widget{
  volume_icon,
  volume,
  layout = wibox.layout.fixed.horizontal
}

return volume_widget

