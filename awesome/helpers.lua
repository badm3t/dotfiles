local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
--local icons = require("icons.init")
--local notifications = require("notifications")
local naughty = require("naughty")

local helpers = {}

helpers.colorize_text = function(text, color)
    return "<span foreground='"..color.."'>"..text.."</span>"
end


helpers.widget_timer = function(callback, timeout)
  timeout = timeout or 0.5
  if callback then
    timer = gears.timer({ timeout = timeout })
    timer:start()
    timer:connect_signal("timeout", callback)
  end
end

helpers.bar_widget = function(color)
  local widget = wibox.widget{
    widget = wibox.widget.textbox,
    value = 0,
    min_value = 0,
    max_value = 100,
    fg = color,
    align = "center",
    valign = "center",
    forced_width = dpi(50),
    forced_height = dpi(50),
  }

  return widget
end

helpers.create_button = function(symbol, color, hover_color, cmd, key)
  local icon = wibox.widget {
    symbol = symbol,
    --markup = helpers.colorize_text(symbol, color),
    align = "center",
    valign = "center",
    font = "icomoon 18",
    forced_width = dpi(50),
    forced_height = dpi(50),
    widget = wibox.widget.textbox,
    point = awful.placement.right
  }

  icon.markup = helpers.colorize_text(icon.symbol, color)

  icon:connect_signal("button::press", function(_, _, _, button)
    if button == 3 then
      icon.markup = helpers.colorize_text(icon.symbol, hover_color.."55")
    end
  end)

  icon:connect_signal("button::release", function()
    icon.markup = helpers.colorize_text(icon.symbol, hover_color)
  end)

  icon:connect_signal("mouse::enter", function()
    icon.markup = helpers.colorize_text(icon.symbol, hover_color.."55")
  end)

  icon:connect_signal("mouse::leave", function()
    icon.markup = helpers.colorize_text(icon.symbol, color)
  end)

  -- Adds mousebinds if cmd is provided
  if cmd then
    icon:buttons(gears.table.join(
      awful.button({ }, 1, function ()
        cmd()
      end),
      awful.button({ }, 3, function ()
        cmd()
      end)
    ))
  end

  -- Add keybind to dict, if given
  if key then
    keybinds[key] = cmd
  end

  return icon
end

helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.create_boxed_widget = function(widget, width, height, bg)
  local box = wibox.container.background()
  box.bg = bg
  box.forced_width = width
  box.forced_height = height
  box.shape = helpers.rrect(dpi(12))

  local boxed_widget = wibox.widget{
    {
      {
        nil,
        {
          nil,
          widget,
          layout = wibox.layout.align.vertical,
          expand = "none"
        },
        layout = wibox.layout.align.horizontal,
        --expand = "none"
      },
      widget = box
    },
    margins = dpi(6),
    color = "#FF000000",
    widget = wibox.container.margin
  }

  return boxed_widget
end

return helpers
