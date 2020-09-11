---------------------------
-- Sensurri awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local surface = require("gears.surface")
local gfs = require("gears.filesystem")
local theme_name = "sensurri"
local themes_path = gfs.get_themes_dir()
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/titlebar/"
local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"
local tip = titlebar_icon_path
local taglist_path = "/home/sceptrr/.config/awesome/themes/sensurri/taglist/"


local theme = {}

theme.dpi = dpi
theme.font          = "Iosevka bold 12"

theme.bg_dark       = x.background
theme.bg_normal     = x.background
theme.bg_focus      = x.color8 
theme.bg_urgent     = x.color8
theme.bg_minimize   = x.background
theme.bg_systray    = theme.backgorund

theme.fg_normal     = x.foreground
theme.fg_focus      = x.color6
theme.fg_urgent     = x.color5
theme.fg_minimize   = x.foreground

-- Gaps
theme.useless_gap   = dpi(5)
theme.border_width  = dpi(5) 
theme.screen_margin = dpi(5)

-- Borders
theme.border_normal = x.background
theme.border_focus  = x.background
--theme.border_marked = xrdb.color5
theme.border_radius = dpi(6)

-- Titlebars
theme.titlebars_enabled = true
theme.titlebar_size = dpi(35)
theme.titlebar_title_enabled = false
theme.titlebar_font = "sans bold 9"
theme.titlebar_title_align = "center"
theme.titlebar_position = "top"
theme.titlebar_bg = x.background

theme.titlebar_fg_focus = x.color8
theme.titlebar_fg_normal = x.background

-- Notifications
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = x.color10
theme.notification_bg = x.background
theme.notification_fg = x.foreground
theme.notification_crit_bg = x.background
theme.notification_crit_fg = x.color1
theme.notification_icon_size = dpi(60)
theme.notification_margin = dpi(16)
theme.notification_opacity = 1
theme.notification_font = "sans 11"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 4

-- Edge snap
theme.snap_shape = gears.shape.rectangle
theme.snap_bg = x.foreground
theme.snap_border_width = dpi(3)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
}
-- Widget separator
theme.separator_text = "|"
theme.separator_fg = x.color8

--Wibar(s)
-- Deafult values
theme.wibar_position = "bottom"
theme.wibar_height = dpi(45)
theme.wibar_fg = x.foreground
theme.wibar_bg = x.background
theme.wibar_border_color = x.color0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(380)

theme.prefix_fg = x.color8


-- Tasklist
theme.tasklist_font = "sans medium 8"
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = x.color0
theme.tasklist_fg_focus = x.foreground
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_fg_normal = x.foreground.."77"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_fg_minimize = x.color8
theme.tasklist_bg_urgent = x.background
theme.tasklist_fg_urgent = x.color3
theme.tasklist_spacing = dpi(0)
theme.tasklist_align = "center"

-- Sidebar
-- idk what is it. iq70
theme.sidebar_bg = x.background
theme.sidebar_fg = x.color7
theme.sidebar_opacity = 1
theme.sidebar_position = "left"
theme.sidebar_width = dpi(300)
theme.sidebar_x = 0
theme.sidebar_y = 0
theme.sidebar_border_radius = dpi(40)

-- Dashboard
theme.dashboard_bg = x.color0 .."CC"
theme.dashboard_fg = x.color7

-- Exit screen
theme.exit_screen_bg = x.color0 .. "CC"
theme.exit_screen_fg = x.color7
theme.exit_screen_font = "sans 20"
theme.exit_screen_size = dpi(180)

-- Lock screen
theme.lock_screen_bg = x.color0 .. "CC"
theme.lock_screen_fg = x.color7

-- Taglist icons
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
end

-- Noodle Text Taglist
theme.taglist_text_font = "monospace 18"
-- theme.taglist_text_font = "sans bold 15"
theme.taglist_text_empty    = {"","","","","","","","","",""}
theme.taglist_text_occupied = {"","","","","","","","","",""}
theme.taglist_text_focused  = {"","","","","","","","","",""}
theme.taglist_text_urgent   = {"","","","","","+","","+","+","+"}

theme.taglist_text_color_empty  = {
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22",
    x.foreground.."22"
}

theme.taglist_text_color_occupied  = {
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70",
    x.color4.."70"
}

theme.taglist_text_color_focused  = {
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9,
    x.color9
}

theme.taglist_text_color_urgent   = {
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
    x.color6,
}

-- Prompt
theme.prompt_fg = x.color12

-- Text taglist (default)
theme.taglist_font = "monospace bold 9"
theme.taglist_bg_focus = x.background
theme.taglist_fg_focus = x.color12
theme.taglist_bg_occupied = x.background
theme.taglist_fg_occupied = x.color8
theme.taglist_bg_empty = x.background
theme.taglist_fg_empty = x.background
theme.taglist_bg_urgent = x.background
theme.taglist_fg_urgent = x.color3
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)

theme.gap_single_client = false

-- Menu
theme.menu_height = dpi(35)
theme.menu_width = dpi(180)
theme.menu_bg_normal = x.color0
theme.menu_fg_normal = x.color7
theme.menu_bg_focus = x.color8 .. "55"
theme.menu_fg_focus = x.color7
theme.menu_border_width = dpi(0)
theme.menu_border_color = x.color0

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff000"


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = "/media/hdd2/pics/skull-2.png"
-- theme.menu_submenu_icon = ""

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"



theme.titlebar_close_button_normal = tip .. "close_normal.svg"
theme.titlebar_close_button_focus  = tip .. "close_focus.svg"
theme.titlebar_minimize_button_normal = tip .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus  = tip .. "minimize_focus.svg"
theme.titlebar_ontop_button_normal_inactive = tip .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = tip .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = tip .. "ontop_focus_active.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive  = tip .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active  = tip .. "sticky_focus_active.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = tip .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = tip .. "floating_focus_active.svg"
theme.titlebar_maximized_button_normal_inactive = tip .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive  = tip .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active  = tip .. "maximized_focus_active.svg"

-- hover
theme.titlebar_close_button_normal_hover = tip .. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover  = tip .. "close_focus_hover.svg"
theme.titlebar_minimize_button_normal_hover = tip .. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover  = tip .. "minimize_focus_hover.svg"
theme.titlebar_ontop_button_normal_inactive_hover = tip .. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover  = tip .. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = tip .. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover  = tip .. "ontop_focus_active_hover.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = tip .. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover  = tip .. "sticky_focus_active_hover.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover  = tip .. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover  = tip .. "floating_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = tip .. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover  = tip .. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = tip .. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover  = tip .. "maximized_focus_active_hover.svg"


-- Layout icons
theme.layout_floating  = layout_icon_path .. "floating.png"
theme.layout_max = layout_icon_path .. "max.png"
theme.layout_tile = layout_icon_path .. "tile.png"


-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = x.color4
theme.minimal_tasklist_visible_clients_text = ""
theme.minimal_tasklist_hidden_clients_color = x.color7
theme.minimal_tasklist_hidden_clients_text = ""

-- Volume bar
theme.volume_bar_active_color = x.color5
theme.volume_bar_active_background_color = x.color0
theme.volume_bar_muted_color = x.color8
theme.volume_bar_muted_background_color = x.color0

-- Temperature bar
theme.temperature_bar_active_color = x.color1
theme.temperature_bar_background_color = x.color0

-- CPU bar
theme.cpu_bar_active_color = x.color2
theme.cpu_bar_background_color = x.color0

-- RAM bar
theme.ram_bar_active_color = x.color4
theme.ram_bar_background_color = x.color0

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Numix"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
