-- sketchybar colors — sora palette, inlined.
--
-- History: this module used to hold NO colors, reading them at runtime
-- from themify's theme confs (single source of truth, engine-managed).
-- The engine is gone; each tool now owns its colors close to its config
-- (this file). Palette provenance: themify/themes/sora.conf at the time
-- of the migration — same values, now literal.
--
-- Shape is unchanged: every item/widget imports this table, so only the
-- source of the values changed, not the API.
local r = {
	-- core
	BG = 0xff0e1018,      -- window/pane background
	BG_ALT = 0xff1e2430,  -- secondary surface
	FG = 0xffc8d0e0,      -- primary text
	FG_MUTED = 0xff586478, -- dimmed text
	BORDER = 0xff2a3448,  -- dividers, pane borders
	ACCENT = 0xff80C8E0,  -- the theme's signature color
	ACCENT_2 = 0xffB0A0D8, -- gradient partner (lavender)
	-- status — thresholds and failures only, not syntax
	ERROR = 0xffc46c78,
	WARN = 0xffd0a888,
	OK = 0xff90c8a0,
	INFO = 0xff80c8e0,
	-- hues
	RED = 0xffc46c78,
	GREEN = 0xff90c8a0,
	BLUE = 0xff80c8e0,
	YELLOW = 0xffd4b878,
	ORANGE = 0xffd0a888,
	MAGENTA = 0xffb0a0d8,
	CYAN = 0xff80c8e0,
	PURPLE = 0xffb0a0d8,
	SAGE = 0xff90c8a0,
	ROSE = 0xffd0909c,
	GOLD = 0xffd4b878,
	PEACH = 0xffd0a888,
	TEAL = 0xff78b8b0,
	STEEL = 0xff8898b8,
	SHADOW = 0xff0a0c12,
	-- surfaces
	HIGHLIGHT = 0xff8898b8,
	BG2 = 0xff222838,
	BAR_BORDER = 0xff222838,
	POPUP_BG = 0xff14161e,
	POPUP_BORDER = 0xff586478,
}

-- derived alpha layers (as before: bar bg = BG at 80%, popup bg at 75%)
local bar_bg = (r.BG & 0x00ffffff) | 0xcc000000
local popup_bg = (r.POPUP_BG & 0x00ffffff) | 0xc0000000

return {
	black = r.BG,
	white = r.FG,
	red = r.RED,
	green = r.GREEN,
	blue = r.BLUE,
	yellow = r.YELLOW,
	orange = r.ORANGE,
	magenta = r.MAGENTA,
	grey = r.FG_MUTED,
	shadow = r.SHADOW,
	transparent = 0x00000000,

	accent = {
		primary = r.ACCENT,
		accent_2 = r.ACCENT_2,
		cyan = r.CYAN,
		purple = r.PURPLE,
		sage = r.SAGE,
		rose = r.ROSE,
		gold = r.GOLD,
		peach = r.PEACH,
		teal = r.TEAL,
		steel = r.STEEL,
	},

	-- status, not syntax: thresholds and failures only
	semantic = {
		error = r.ERROR,
		warn = r.WARN,
		ok = r.OK,
		info = r.INFO,
	},

	highlight = r.HIGHLIGHT,
	bar = { bg = bar_bg, border = r.BAR_BORDER },
	popup = { bg = popup_bg, border = r.POPUP_BORDER },
	bg1 = r.BG_ALT,
	bg2 = r.BG2,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
