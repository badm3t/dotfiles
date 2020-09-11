local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")

local cpu_widget = helpers.bar_widget(x.color3)

local function update()
  cpu = {}
  cpu.prev_total = 0
  cpu.prev_idle = 0
  --cpu(core) user nice system idle iowait irq softirq
  regex = "(%a+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)"

  for line in io.lines("/proc/stat") do
    for key, v1, v2, v3, idle, v5, v6, v7, v8 in string.gmatch(line, regex) do
      if key == "cpu" then
        total = v1 + v2 + v3 + idle + v5 + v6 + v7 + v8
        diff_idle = idle - cpu.prev_idle
        diff_total = total - cpu.prev_total
        diff_usage = math.ceil((1000 * (diff_total - diff_idle) / diff_total + 5) / 10)

        cpu.usage = diff_usage
        cpu.prev_idle = idle
        cpu.prev_total = total
        break
      end
    end
  end
  cpu_widget.markup = helpers.colorize_text(cpu.usage, x.color7).." %"
end


local function lines_match(regexp, path)
    local lines = {}
    for line in io.lines(path) do
        if string.match(line, regexp) then
            lines[#lines + 1] = line
        end
    end
    return lines
end

helpers.widget_timer(update)

return cpu_widget
