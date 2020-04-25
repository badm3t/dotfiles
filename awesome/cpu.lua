local watch = require("awful.widget.watch")
local wibox = require("wibox")

local cpu_text =
  wibox.widget {
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}

local cpu_widget = watch("cpu", 1)

return cpu_widget
