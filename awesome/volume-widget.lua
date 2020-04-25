local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local GET_VOLUME_CMD = 'amixer sget Master'
local INC_VOLUME_CMD = 'amixer sset Master 2%+'
local DEC_VOLUME_CMD = 'amixer sset Master 2%-'
local TOG_VOLUME_CMD = 'amixer sset Master toggle'

local volume_widget = {}
local text_widget = wibox.widget{
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

function volume_widget.text_volume(args)
    local widget = wibox.container.margin(
        text_widget,
        args.left or 0 ,
        args.right or 0,
        args.top or 0,
        args.bottom or 0
    )
    return widget
end

function volume_widget.widget(args)

    local args = args or {}

    local main_color = args.main_color or beautiful.xrdb.color4
    local mute_color = args.mute_color or beautiful.fg_urgent
    local width = args.width or 50
    local shape = args.shape or 'bar'
    local margins = args.margins or 14

    local get_volume_cmd = args.get_volume_cmd or GET_VOLUME_CMD
    local inc_volume_cmd = args.inc_volume_cmd or INC_VOLUME_CMD
    local dec_volume_cmd = args.dec_volume_cmd or DEC_VOLUME_CMD
    local tog_volume_cmd = args.tog_volume_cmd or TOG_VOLUME_CMD

    local volumebar_widget = wibox.widget {
        max_value = 1,
        forced_width = width,
        color = main_color,
        background_color = '#4b5056',
        shape = gears.shape[shape],
        margins = {
            top = margins,
            bottom = margins,
        },
        widget = wibox.widget.progressbar
    }

    local update_graphic = function(widget, stdout, _, _, _)
        local mute = string.match(stdout, "%[(o%D%D?)%]")    -- \[(o\D\D?)\] - [on] or [off]
        local volume = string.match(stdout, "(%d?%d?%d)%%")  -- (\d?\d?\d)\%)
        volume = tonumber(string.format("% 3d", volume))
        text_widget.markup= "<span color='"..beautiful.xrdb.color4.."'>"..volume.. "%</span>"
        text_widget.font = beautiful.font
        widget.value = volume / 100;
        widget.color = mute == "off"
                and mute_color
                or main_color

    end

    volumebar_widget:connect_signal("button::press", function(_, _, _, button)
        if (button == 4) then
            awful.spawn(inc_volume_cmd)
        elseif (button == 5) then
            awful.spawn(dec_volume_cmd)
        elseif (button == 1) then
            awful.spawn(tog_volume_cmd)
        end

        spawn.easy_async(get_volume_cmd, function(stdout, stderr, exitreason, exitcode)
            update_graphic(volumebar_widget, stdout, stderr, exitreason, exitcode)
        end)
    end)

    watch(get_volume_cmd, 1, update_graphic, volumebar_widget)

    return wibox.container.margin(
          volumebar_widget,
          args.left or 0,
          args.right or 0,
          args.top or 0,
          args.bottom or 0
      )
end

return volume_widget
