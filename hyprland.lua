-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-1",
	mode = "3440x1440@174.96",
	position = "0x0",
	scale = "auto",
	vrr = 2,
})
hl.monitor({
	output = "HDMI-A-2",
	mode = "preferred",
	position = "-1920x300",
	scale = "auto",
})
-- hl.monitor({
-- 	output = "HDMI-A-1",
-- 	mode = "preferred",
-- 	position = "-5760x800",
-- 	scale = "auto",
-- })
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "alacritty"
local fileManager = "nemo"
local wallpaperManager = "waypaper"
local menu = [[tofi-drun | xargs -I{} hyprctl dispatch 'hl.exec_cmd("uwsm app -- {}")']]

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("exec-once = hyprctl setcursor Bibata-Modern-Ice 24")
	hl.exec_cmd("uwsm app -- ags run --gtk 4")
	hl.exec_cmd("uwsm app -- dunst")
	hl.exec_cmd("uwsm app -- waypaper --restore")
	hl.exec_cmd("uwsm app -- zen-browser", { workspace = "1 silent" })
	hl.exec_cmd("uwsm app -- spotify-launcher", { workspace = "special:spotify silent" })
	hl.exec_cmd("uwsm app -- vesktop", { workspace = "special:discord silent" })
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- place at ~/.config/uwsm/env instead

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
hl.permission({
	binary = "/usr/(bin|local/bin)/grim",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
	type = "screencopy",
	mode = "allow",
})

---------------------
-- LOOK AND FEEL ----
---------------------

require("styles.macos")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "dwindle",
	},

	binds = {
		workspace_back_and_forth = true,
		workspace_center_on = 1,
		allow_pin_fullscreen = true,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = false,
		middle_click_paste = false,
	},

	render = {
		direct_scanout = 2,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:altgr, compose:menu",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},

	cursor = {
		inactive_timeout = 1,
		hide_on_key_press = true,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
-- 	name = "epic-mouse-v1",
-- 	sensitivity = -0.5,
-- })

-------------------
---- ANIMATION ----
-------------------

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = false, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = false, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = false, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-----------------
---- LAYOUTS ----
-----------------

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local primaryMonitor = "DP-1"
local secondaryMonitor = "HDMI-A-2"
-- local penDisplay = "HDMI-A-1"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local closeWindowBind = hl.bind(mainMod .. " + backslash", hl.dsp.window.close())
local killWindowBind = hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.kill())
closeWindowBind:set_enabled(true)
killWindowBind:set_enabled(false)

-- hl.bind(
-- 	mainMod .. " + M",
-- 	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
-- )
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm app -- " .. wallpaperManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

-- Switch monitors
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = secondaryMonitor }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = primaryMonitor }))
hl.bind(mainMod .. " + ALT + comma", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + ALT + period", hl.dsp.focus({ monitor = "right" }))

hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ monitor = secondaryMonitor }))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ monitor = primaryMonitor }))
hl.bind(mainMod .. " + SHIFT + ALT + comma", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + ALT + comma", hl.dsp.window.move({ monitor = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.workspace_rule({ workspace = "1", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "2", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "3", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "4", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "5", monitor = primaryMonitor })
hl.workspace_rule({ workspace = "6", monitor = secondaryMonitor })
hl.workspace_rule({ workspace = "7", monitor = secondaryMonitor })
hl.workspace_rule({ workspace = "name:gaming", monitor = primaryMonitor })

-- special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:spotify" }))
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:discord" }))
hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:magic" }))

-- gaming workspace
hl.bind(mainMod .. " + G", hl.dsp.focus({ workspace = "name:gaming" }))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "name:gaming" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p spotify next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p spotify previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("playerctl -p spotify volume 0.03+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("playerctl -p spotify volume 0.03-"),
	{ locked = true, repeating = true }
)

-- Passthrough to discord
hl.bind(mainMod .. " + M", hl.dsp.send_shortcut({ mods = "CONTROL + SHIFT", key = "M", window = "class:goofcord" }))
hl.bind(
	mainMod .. " + M",
	hl.dsp.send_shortcut({ mods = "CONTROL + SHIFT", key = "M", window = "initaltitle:Discord" })
)

-- Screenshot
hl.bind(
	mainMod .. " + Z",
	hl.dsp.exec_cmd(
		[[grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | wl-copy]]
	)
)
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(
	mainMod .. " + SHIFT + CONTROL + Z",
	hl.dsp.exec_cmd([[grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" - | wl-copy]])
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	match = { class = "steam_add_\\d*" },
	fullscreen = true,
	immediate = true,
	workspace = "name:gaming",
})
hl.window_rule({
	match = { class = "gamescope" },
	fullscreen = true,
	immediate = true,
	workspace = "name:gaming",
})
hl.window_rule({
	match = { class = "Minecraft*" },
	fullscreen = true,
	immediate = true,
	workspace = "name:gaming",
})

hl.window_rule({ match = { class = "spotify" }, workspace = "special:spotify silent" })
hl.window_rule({ match = { initial_title = "Discord" }, workspace = "special:discord silent" })
hl.window_rule({ match = { class = "waypaper" }, float = true })

hl.window_rule({ match = { class = "org.godotengine.ProjectManager" }, float = true, size = { 966, 621 } })
hl.window_rule({
	match = { initial_title = "negative:Godot", initial_class = "org.godotengine.Editor" },
	float = true,
})
hl.window_rule({ match = { initial_class = "Rhythmic Reelers" }, float = true })

hl.window_rule({ match = { initial_title = "Calculator" }, float = true, size = { 600, 790 } })

hl.window_rule({ match = { initial_class = "Secure CRAN Mirrors" }, float = true })
hl.window_rule({ match = { initial_class = "PureRef" }, float = true })

hl.window_rule({ match = { initial_class = "nemo" }, float = true, size = { 1089, 652 } })

hl.window_rule({
	match = { class = "steam", float = false },
	workspace = 5,
})
hl.window_rule({
	match = { initial_class = "steam", initial_title = "negative:Steam" },
})
hl.window_rule({ match = { initial_title = "Friends List" }, size = { 328, 900 }, move = { 3056, 54 } })
hl.window_rule({
	name = "steam notifs",
	match = { class = "steam", float = true },
	rounding = 0,
	no_blur = true,
})

-- hl.exec_cmd("sleep 10 && playerctl -p spotify volume 0.10")
