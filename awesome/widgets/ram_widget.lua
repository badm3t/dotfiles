local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")

local ram_widget = helpers.bar_widget(x.color3)
ram_widget.forced_width = dpi(80)

local function update()
  mem = {}

  for line in io.lines("/proc/meminfo") do
    for key, val in string.gmatch(line, "(%a+):%s+(%d+).*") do
      if key == "MemTotal" then mem.total = math.floor(val / 1024 + 0.5)
      elseif key == "MemFree" then mem.free = math.floor(val / 1024 + 0.5)
      elseif key == "Buffers" then mem.buffers = math.floor(val / 1024 + 0.5)
      elseif key == "Cached" then mem.cached = math.floor(val / 1024 + 0.5)
      elseif key == "SwapTotal" then mem.swap = math.floor(val / 1024 + 0.5)
      elseif key == "SwapFree" then mem.swap_free = math.floor(val / 1024 + 0.5)
      elseif key == "SReclaimable" then mem.recl = math.floor(val / 1024 + 0.5)
      end
    end
  end

  mem.used = mem.total - mem.free - mem.buffers - mem.cached - mem.recl
  mem.swap_used = mem.swap - mem.swap_free
  mem.percent = math.floor(mem.used / mem.total * 100)

  ram_widget.value = mem.percent

  if mem.percent <= 20 then
    ram_widget.markup = "Mem: "..helpers.colorize_text(mem.percent, x.color7).." %"
  elseif mem.percent > 20 and mem.percent <= 50 then
    ram_widget.markup = "Mem: "..helpers.colorize_text(mem.percent, x.color2).." %"
  elseif mem.percent > 50 and mem.percent <= 85 then
    ram_widget.markup = "Mem: "..helpers.colorize_text(mem.percent, x.color5).." %"
  elseif mem.percent > 85 then
    ram_widget.markup = "Mem: "..helpers.colorize_text(mem.percent, x.color9).." %"
  end
end

helpers.widget_timer(update)

return ram_widget
