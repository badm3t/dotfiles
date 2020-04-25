local watch = require('awful.widget.watch')
local wibox = require('wibox')

local ram_text = wibox.widget{
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local ram_widget = watch('bash -c "LANGUAGE=en_US.UTF-8 free -m | grep -z Mem.*Swap.*"', 10,
  function(widget, stdout, stderr, exitreason, exitcode)
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
          stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

    local used_percent = math.floor((used + used_swap) / (total + total_swap) * 100 + 0.5)
    widget.text = used_percent .. "%"
  end,
  ram_text
)

return ram_widget
