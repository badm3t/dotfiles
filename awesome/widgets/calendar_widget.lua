local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local styles = {}

styles.month = {
  padding      = 10,
  bg_color     = x.background,
  fg_color     = x.color7,
  border_width = 0,
}

styles.normal = {}
styles.focus = {
  fg_color = x.color1,
  bg_color = x.color5.."00",
  markup   = function(t) return '<b>' .. t .. '</b>' end,
}

styles.header = {
  fg_color = x.color4,
  bg_color = x.color1.."00",
  markup   = function(t) return '<span font_desc="iosevka bold 20">'..t..'</span>' end,
}

styles.weekday = {
  fg_color = x.color7,
  bg_color = x.color1.."00",
  padding = 3,
  markup   = function(t) return '<b>' .. t .. '</b>' end,
}

local function decorate_cell(widget, flag, date)
  if flag=='monthheader' and not styles.monthheader then
    flag = 'header'
  end
  local props = styles[flag] or {}
  if props.markup and widget.get_text and widget.set_markup then
    widget:set_markup(props.markup(widget:get_text()))
  end
  -- Change bg color for weekends
  local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
  local weekday = tonumber(os.date('%w', os.time(d)))
  local default_bg = x.color0.."00"
  local default_fg = x.color7
  local ret = wibox.widget {
    {
      widget,
      margins = (props.padding or 2) + (props.border_width or 0),
      widget  = wibox.container.margin
    },
    shape              = props.shape,
    shape_border_color = props.border_color or x.background,
    shape_border_width = props.border_width or 0,
    fg                 = props.fg_color or default_fg,
    bg                 = props.bg_color or default_bg,
    widget             = wibox.container.background
  }
  return ret
end

local calendar_widget = wibox.widget{
  date     = os.date('*t'),
  font = "iosevka 13",
  long_weekdays = false,
  spacing = dpi(3),
  fn_embed = decorate_cell,
  widget   = wibox.widget.calendar.month,
}

return calendar_widget
