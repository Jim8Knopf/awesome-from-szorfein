local beautiful = require("beautiful")
local widget = require("util.widgets")
local helpers = require("helpers")
local wibox = require("wibox")
local aspawn = require("awful.spawn")
local font = require("util.font")

-- beautiful vars
local spacing = beautiful.widget_spacing or 1

-- root
local brightness_root = class()

function brightness_root:init(args)
  -- options
  self.fg = args.fg or beautiful.widget_brightness_fg or M.x.on_surface
  self.icon = args.icon or beautiful.widget_brightness_icon or { "", M.x.on_surface }
  self.mode = args.mode or 'text' -- possible values: text, progressbar, slider
  self.layout = args.layout or beautiful.widget_brightness_layout or 'horizontal' -- possible values: horizontal , vertical
  self.bar_size = args.bar_size or 200
  self.bar_colors = args.bar_colors or beautiful.bar_color or M.x.primary
  self.title = args.title or beautiful.widget_brightness_title or { "BRI", M.x.on_background }
  -- base widgets
  self.wicon = font.button(self.icon[1], self.icon[2], M.t.medium)
  self.wtitle = font.h6(self.title[1], self.title[2])
  self.wtext = font.button("")
  self.widget = self:make_widget()
end

function brightness_root:make_widget()
  if self.mode == "slider" then
    return self:make_slider()
  elseif self.mode == "progressbar" then
    return self:make_progressbar()
  else
    return self:make_text()
  end
end

function brightness_root:make_text()
  local w = widget.box_with_margin(self.want_layout, { self.wicon, self.wtext }, spacing)
  awesome.connect_signal("daemon::brightness", function(brightness)
    self.wtext.markup = helpers.colorize_text(brightness, self.fg, M.t.medium)
  end)
  return w
end

function brightness_root:make_slider()
  local slider = widget.make_a_slider(1, self.bar_colors)
  local w = widget.box(self.layout, { self.wicon, slider }, 4)
  -- set level
  slider:connect_signal('property::value', function()
    aspawn.with_shell('light -S ' .. slider.value)
  end)
  -- get current level
  awesome.connect_signal("daemon::brightness", function(brightness)
    slider.minimum = 1
    slider:set_value(brightness)
  end)
  return w
end

function brightness_root:make_progressbar_vert(p)
  local w = wibox.widget {
    {
      nil,
      widget.box('vertical', { self.wtitle, self.wtext }),
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    {
      nil,
      widget.box('vertical', { p, self.wicon }),
      expand = "none",
      layout = wibox.layout.align.vertical
    },
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
  }
  return w
end

function brightness_root:make_progressbar()
  local p = widget.make_progressbar(_, self.bar_size, self.bar_colors)
  local wp = widget.progressbar_layout(p, self.layout)
  local w
  if self.want_layout == 'vertical' then
    w = self:make_progressbar_vert(wp)
  else
    w = widget.box_with_margin(self.want_layout, { self.wicon, wp }, 8)
  end
  awesome.connect_signal("daemon::brightness", function(brightness)
    p.value = brightness
    self.wtext.markup = helpers.colorize_text(brightness.."%", self.fg, M.t.medium)
  end)
  return w
end

-- herit
local brightness_widget = class(brightness_root)

function brightness_widget:init(args)
  brightness_root.init(self, args)
  return self.widget
end

return brightness_widget
