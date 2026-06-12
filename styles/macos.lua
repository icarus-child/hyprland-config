hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = "rgb(ffffff)",
			inactive_border = "rgba(1a1a1a44)",
		},
	},
	-- source = ./active-border.piece.conf

	animations = {
		enabled = true,
	},

	decoration = {
		rounding = 10,
		rounding_power = 4,

		active_opacity = 1.0,
		-- inactive_opacity = 0.8,

		dim_inactive = true,
		dim_strength = 0.1,

		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "rgba(1a1a1a99)",
			color_inactive = "rgba(1a1a1a44)",
			scale = 1,
		},

		-- https://wiki.hyprland.org/Configuring/Variables/#blur
		blur = {
			enabled = true,
			size = 5,
			passes = 3,

			vibrancy = 0.1696,
		},
	},
})

hl.layer_rule({ match = { namespace = "launcher" }, blur = true, dim_around = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
-- -- layerrule = blur, gtk4-layer-shell
hl.window_rule({ match = { fullscreen = true }, no_dim = true })
