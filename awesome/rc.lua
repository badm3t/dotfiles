pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local beautiful = require("beautiful")
local helpers = require("helpers")


local themes = { "sensurri" }
local theme = themes[1]

local icon_themes = { "linebit", "drops" }
local icon_theme = icon_themes[2]

local bar_themes = { "sensurri" }
local bar_theme = bar_themes[1]

local notifications_themes = { "sensurri" }
local notification_theme = notifications_themes[1]

local sidebar_themes = { "sensurri" }
local sidebar_theme = sidebar_themes[1]

local xrdb = beautiful.xresources.get_current_theme()
dpi = beautiful.xresources.apply_dpi

require("demons")
local ram_bar = require("elements.ram_bar")

x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

user = {
  terminal = "alacritty",
  editor = os.getenv("vim"),
  editor_cmd = "alacritty --class editor -e vim",
  browser = "chromium",
  modkey = "Mod4",
  screen_shot = "maim -s | xclip -selection clipboard -t image/png",

  dirs = {
    downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
    documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
    music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
    pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
    videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
    screenshots = os.getenv("XDG_SCREENSHOTR_DIR") or "~/Pictures/Screenshots",
  },
  lock_screen_custom_password = "awesome",
}

local commands = {
  poweroff = function()
    awful.spawn.with_shell("poweroff")
  end,
  reboot = function()
    awful.spawn.with_shell("reboot")
  end,
}

local apps = {}

apps.browser = function ()
    awful.spawn(user.browser, {switchtotag = true})
end

local keybinds = {}

local create_app_window = function()
  local app_window = wibox{ visible = false, type = "dock", ontop = true }

  return app_window
end

local poweroff_app = wibox{ visible = false, type = "dock", ontop = true }

-- Last callback of stack
local app_grabber

local function hide_app_window(widget)
  awful.keygrabber.stop(app_grabber)
  --poweroff_app.visible = false
  widget.visible = false
end

local function show_app_window(widget)
  app_grabber = awful.keygrabber.run(function(_, key, event)
    local invalid_key = false

    if event == "release" then return end

    if keybinds[key] then
      keybinds[key]()
    else
      invalid_key = true
    end

    if not invalid_key or key == "Escape" then
      hide_app_window(widget)
    end
  end)
  --poweroff_app.visible = true
  widget.visible = true
end


local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/"
beautiful.init(theme_dir .. "theme.lua")

-- widgets
--local calendar_widget = require("widgets.calendar_widget")
--local calendar = helpers.create_boxed_widget(calendar_widget, dpi(350), dpi(340), x.color0)

--local dashboard = wibox{ visible = true, type = "normal", ontop = true }
--dashboard.bg = x.color0
--dashboard.fg = x.color7
--dashboard.width = dpi(350)
--dashboard.height = dpi(340)
--dashboard.class = "Dashboard"

--dashboard:setup{
 -- {
  --  calendar,
   -- layout = wibox.layout.flex.horizontal,
  --},
  --class_name = "Dashboard",
  --layout = wibox.layout.flex.horizontal
--}
--awful.placement.top(dashboard)

-- Right widgets/buttons/icons
--local my_browser = helpers.create_button("", x.color4, x.color5, apps.browser, _)
local volume = require("widgets.volume_widget")
local poweroff_menu = helpers.create_button("", x.color4, x.color4, _, _)

local reboot = helpers.create_button("", x.color5, x.color5, commands.reboot, _)
reboot.font = "icomoon 40"
reboot.forced_width = dpi(100)
reboot.forced_height = dpi(100)

local settings = helpers.create_button("", x.color5, x.color5, _, _)
settings.font = "icomoon 40"
settings.forced_width = dpi(100)
settings.forced_height = dpi(100)

local ram_widget = require("widgets.ram_widget")
local cpu_widget = require("widgets.cpu2")

local poweroff = helpers.create_button("", x.color5, x.color5, commands.poweroff, _)
poweroff.font = "icomoon 40"
poweroff.forced_width = dpi(100)
poweroff.forced_height = dpi(100)

-- Poweroff menu/wibox
awful.placement.maximize(poweroff_app)

poweroff_app.bg = x.background.."99"
--poweroff_app.bg = "#00000000"
poweroff_app.fg = x.foreground

poweroff_menu:buttons(gears.table.join(
  awful.button({}, awful.button.names.LEFT, function()
    show_app_window(poweroff_app)
  end),
  awful.button({}, awful.button.names.MIDDLE, function()
    hide_app_window(poweroff_app)
  end)
))


local function create_stripe(widgets, bg)
  local buttons = wibox.widget {
    layout = wibox.layout.fixed.horizontal
  }

  for _, widget in ipairs(widgets) do
    buttons:add(widget)
  end

  local stripe = wibox.widget {
    {
      nil,
      {
        nil,
        buttons,
        expand = "none",
        layout = wibox.layout.align.horizontal
      },
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    bg = bg,
    widget = wibox.container.background
  }

  return stripe
end




poweroff_app:setup {
  {
    create_stripe({reboot, settings, poweroff}, x.background.."44"),
    layout = wibox.layout.flex.vertical
  },
  bg = x.background.."99",
  widget = wibox.container.background
}


-- ----------| Error handling |----------
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify(
    {
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
    }
  )
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal(
    "debug::error",
    function(err)
      -- Make sure we don't go into an endless error loop
      if in_error then
        return
      end
      in_error = true

      naughty.notify(
        {
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err)
        }
      )
      in_error = false
    end
  )
end

beautiful.get().wallpaper = "/home/sceptrr/Downloads/gli.jpg"
--beautiful.awesome_icon = "/media/hdd2/pics/skull.svg"

terminal = "alacritty"
editor = os.getenv("vim") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
code_editor = "emacs"
modkey = "Mod4"
screen_shot = "maim -s | xclip -selection clipboard -t image/png"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.floating,
  -- awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se
}

-- ----------| Menu |-----------
myawesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end
  },
  {
    "restart",
    awesome.restart
  },
  {
    "quit",
    function()
      awesome.quit()
    end
  }
}

mymainmenu = awful.menu(
  {
    items = {
      {"awesome", myawesomemenu},
      {"terminal", terminal},
      {"reboot", "reboot"},
      {"poweroff", "poweroff"}
    }
  }
)

mylauncher = awful.widget.launcher(
  {
    image = beautiful.awesome_icon,
    menu = mymainmenu
  }
)

-- ----------| Menubar configuration |----------
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- ----------| Keyboard map indicator and switcher |----------
local keyboard_icon = wibox.widget{
  markup = '<',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
}

mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1,
    function(t)
      t:view_only()
    end
  ),
  awful.button({modkey}, 1,
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end
  ),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({modkey}, 3,
    function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end
  ),
  awful.button({}, 4,
    function(t)
      awful.tag.viewnext(t.screen)
    end
  ),
  awful.button({}, 5,
    function(t)
      awful.tag.viewprev(t.screen)
    end
  )
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1,
    function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end
  ),
  awful.button({}, 3,
    function()
      awful.menu.client_list({theme = {width = 250}})
    end
  ),
  awful.button({}, 4,
    function()
      awful.client.focus.byidx(1)
    end
  ),
  awful.button({}, 5,
    function()
      awful.client.focus.byidx(-1)
    end
  )
)

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local update_taglist = function(item, tag, index)
  if tag.selected then
      item.markup = helpers.colorize_text(beautiful.taglist_text_focused[index], beautiful.taglist_text_color_focused[index])
  elseif tag.urgent then
      item.markup = helpers.colorize_text(beautiful.taglist_text_urgent[index], beautiful.taglist_text_color_urgent[index])
  elseif #tag:clients() > 0 then
      item.markup = helpers.colorize_text(beautiful.taglist_text_occupied[index], beautiful.taglist_text_color_occupied[index])
  else
      item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_text_color_empty[index])
  end
end

local update_taglist_img = function (item, tag, index)
    if tag.selected then
        item.image = beautiful.taglist_icons_focused[index]
    elseif tag.urgent then
        item.image = beautiful.taglist_icons_urgent[index]
    elseif #tag:clients() > 0 then
        item.image = beautiful.taglist_icons_occupied[index]
    else
        item.image = beautiful.taglist_icons_empty[index]
    end
end

awful.screen.connect_for_each_screen(
  function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local l = awful.layout.suit
    local layouts = {
      l.fair,
      l.fair,
      l.fair,
      l.fair,
      l.fair,
      l.fair,
      l.fair,
      l.fair,
      l.floating
    }

    local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

    awful.tag(tagnames, s, layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      layout = wibox.layout.fixed.horizontal,
      buttons = taglist_buttons,
      widget_template = {
        widget = wibox.widget.textbox,
        --widget = wibox.widget.imagebox,
        create_callback = function(self, tag, index, _)
          self.align = "center"
          self.valign = "center"
          self.forced_width = dpi(50)
          self.font = beautiful.taglist_text_font

          update_taglist(self, tag, index)
        end,
        update_callback = function(self, tag, index, _)
          update_taglist(self, tag, index)
        end,
      }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons
    }

    -- Create clock
    s.mytextclock = wibox.widget.textclock(
      "<span color='"..x.foreground.."'> %a %b %d, %H:%M</span>"
    )

    s.mytextclock:buttons(gears.table.join(
      awful.button({}, awful.button.names.LEFT, function()
        --show_app_window(calendar_widget)
      end),
      awful.button({}, awful.button.names.MIDDLE, function()
        --hide_app_window(calendar_widget)
      end)
    ))

    -- Create the wibox
    s.mywibox = awful.wibar({
      position = "top",
      screen = s,
      bg = x.background,
    })

    local clock_icon = wibox.widget {
      image = "/home/sceptrr/Downloads/sk.png",
      widget = wibox.widget.imagebox,
      forced_height = 37,
      forced_width = 37
    }

    -- Add widgets to the wibox
    -- With this setup clock will be always in the middle
    s.mywibox:setup {
      {
        layout = wibox.layout.align.horizontal,
        {
          -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          s.mytaglist,
          s.mypromptbox,
        },
        nil,
        {
          -- Right widgets
          systray,
          volume,
          cpu_widget,
          ram_widget,
          poweroff_menu,
          layout = wibox.layout.fixed.horizontal,
        },
      },
        -- Middle widget
      {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        {
          layout = wibox.layout.fixed.horizontal,
          clock_icon,
          s.mytextclock
        }
      },
      layout = wibox.layout.stack
    }

  end
)
-- }}}

-- {{{ Mouse bindings
root.buttons(
  gears.table.join(
    awful.button(
      {},
      3,
      function()
        mymainmenu:toggle()
      end
    ),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    -- custom mouse bindings
  )
)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key({modkey}, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({modkey}, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({modkey}, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),
  awful.key({modkey}, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({modkey},"k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),
  awful.key({modkey}, "w",
    function()
      mymainmenu:show()
    end,
    { description = "show main menu", group = "awesome" }
  ),
  -- Layout manipulation
  awful.key({modkey, "Shift"}, "j",
    function()
      awful.client.swap.byidx(1)
    end,
    { description = "swap with next client by index", group = "client" }
  ),
  awful.key({modkey, "Shift"}, "k",
    function()
      awful.client.swap.byidx(-1)
    end,
    { description = "swap with previous client by index", group = "client" }
  ),
  awful.key({modkey, "Control"}, "j",
    function()
      awful.screen.focus_relative(1)
    end,
    { description = "focus the next screen", group = "screen" }
  ),
  awful.key({modkey, "Control"}, "k",
    function()
      awful.screen.focus_relative(-1)
    end,
    { description = "focus the previous screen", group = "screen" }
  ),
  awful.key({modkey}, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }
  ),
  awful.key({modkey}, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }
  ),
  awful.key({modkey, "Shift"}, "p", function()
    awful.util.spawn_with_shell(screen_shot) end, {}),
  -- ---------- Custom keybindings ----------
  awful.key({modkey}, "c",
    function()
      awful.spawn(browser)
    end,
    { description = "open a browser", group = "launcher" }
  ),
  awful.key({modkey}, "v",
    function()
      awful.spawn(code_editor)
    end,
    { description = "open a code editor", group = "launcher" }
  ),
  awful.key({modkey}, "t",
    function()
      awful.spawn("thunar")
    end,
    { description = "open a fm", group = "launcher" }
  ),
  awful.key({modkey}, "s",
    function()
      awful.spawn("steam")
    end,
    { description = "open steam", group = "launcher" }
  ),

  -- ---------- My programms END ----------
  -- Standard program
  awful.key({modkey}, "Return",
    function()
      awful.spawn(terminal)
    end,
    { description = "open a terminal", group = "launcher" }
  ),
  awful.key(
    {modkey, "Control"}, "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }
  ),
  awful.key({modkey, "Shift"}, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({modkey}, "l",
    function()
      awful.tag.incmwfact(0.05)
    end,
    { description = "increase master width factor", group = "layout" }
  ),
  awful.key({modkey}, "h",
    function()
      awful.tag.incmwfact(-0.05)
    end,
    { description = "decrease master width factor", group = "layout" }
  ),
  awful.key({modkey, "Shift"}, "h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "increase the number of master clients", group = "layout" }
  ),
  awful.key({modkey, "Shift"}, "l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "decrease the number of master clients", group = "layout" }
  ),
  awful.key({modkey, "Control"}, "h",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    { description = "increase the number of columns", group = "layout" }
  ),
  awful.key({modkey, "Control"}, "l",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    { description = "decrease the number of columns", group = "layout" }
  ),
  awful.key({modkey}, "space",
    function()
      awful.layout.inc(1)
    end,
    { description = "select next", group = "layout" }
  ),
  awful.key({modkey, "Shift"}, "space",
    function()
      awful.layout.inc(-1)
    end,
    { description = "select previous", group = "layout" }
  ),
  awful.key({modkey, "Control"}, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", {raise = true})
      end
    end,
    { description = "restore minimized", group = "client" }
  ), -- Prompt
  awful.key({modkey}, "r",
    function()
      awful.screen.focused().mypromptbox:run()
    end,
    { description = "run prompt", group = "launcher" }
  ),
  awful.key({modkey}, "x",
    function()
      awful.prompt.run {
        prompt = "Run Lua code: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }
  ), -- Menubar
  awful.key({modkey}, "p",
    function()
      menubar.show()
    end,
    { description = "show the menubar", group = "launcher" }
  )
)

clientkeys =
  gears.table.join(
  awful.key({modkey}, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }
  ),
  awful.key({modkey, "Shift"}, "c",
    function(c)
      c:kill()
    end,
    { description = "close", group = "client" }
  ),
  awful.key({modkey, "Control"}, "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({modkey, "Control"}, "Return",
    function(c)
      c:swap(awful.client.getmaster())
    end,
    { description = "move to master", group = "client" }
  ),
  awful.key({modkey}, "o",
    function(c)
      c:move_to_screen()
    end,
    { description = "move to screen", group = "client" }
  ),
  awful.key({modkey}, "t",
    function(c)
      c.ontop = not c.ontop
    end,
    { description = "toggle keep on top", group = "client" }
  ),
  awful.key({modkey}, "n",
    function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    { description = "minimize", group = "client" }
  ),
  awful.key({modkey}, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize", group = "client" }
  ),
  awful.key({modkey, "Control"}, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }
  ),
  awful.key({modkey, "Shift"}, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" }
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys =
    gears.table.join(
    globalkeys, -- View tag only.
    awful.key(
      {modkey},
      "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #" .. i, group = "tag"}
    ),
    -- Toggle tag display.
    awful.key(
      {modkey, "Control"},
      "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "tag"}
    ),
    -- Move client to tag.
    awful.key(
      {modkey, "Shift"},
      "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #" .. i, group = "tag"}
    ),
    -- Toggle tag on focused client.
    awful.key(
      {modkey, "Control", "Shift"},
      "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "tag"}
    )
  )
end

clientbuttons =
  gears.table.join(
  awful.button(
    {},
    1,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
    end
  ),
  awful.button(
    {modkey},
    1,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end
  ),
  awful.button(
    {modkey},
    3,
    function(c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end
  )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry"
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin", -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester" -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {floating = true}
  },
  { rule = { class_name = "Dashboard" }, properties = { screen = 1, tag = beautiful.tagnames[9], maximized = false }},
  -- Set rules for my apps.
  { rule = { class = "Chromium" },
    properties = { screen = 1, tag = beautiful.tagnames[2], maximized = false }
  },
  { rule = { class = "Firefox" },
    properties = { screen = 1, tag = beautiful.tagnames[2], maximized = false }
  },
  { rule = { class = "Steam" },
    properties = { screen = 1, tag = beautiful.tagnames[7], maximized = false }
  },
  { rule = { class = "Transmission" },
    properties = { screen = 1, tag = beautiful.tagnames[6], maximized = false }
  },
  { rule = { class = "libreoffice" },
    properties = { screen = 1, tag = beautiful.tagnames[6], maximized = false }
  },
  { rule = { class = "emacs" },
    properties = { screen = 1, tag = beautiful.tagnames[1] }
  },
   -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "normal", "dialog" }},
    properties = { titlebars_enabled = beautiful.titlebars_enabled }
  }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
  "manage",
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
      awful.client.setslave(c)
    end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
  "request::titlebars",
  function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
      awful.button(
        {},
        1,
        function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
        end
      ),
      awful.button(
        {},
        3,
        function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.resize(c)
        end
      )
    )

    awful.titlebar(c):setup {
      {
        -- Left
        --awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal
      },
      {
        -- Middle
        {
          -- Title
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal
      },
      {
        -- Right
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
  end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter",
  function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
  end
)

client.connect_signal("focus",
  function(c)
    c.border_color = beautiful.border_focus
  end
)

client.connect_signal("unfocus",
  function(c)
    c.border_color = beautiful.border_normal
  end
)

-- No borders if only one tiled client 
screen.connect_signal("arrange",
  function(s) 
    for _, c in pairs(s.clients) do 
      if #s.tiled_clients == 1 and c.floating == false 
        then c.border_width = 0 
      elseif #s.tiled_clients > 1 
        then c.border_width = beautiful.border_width 
      end
    end 
  end
)
-- }}}
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
