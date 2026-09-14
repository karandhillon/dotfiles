-- sketchybar colors — TokyoNight Night palette, inlined.
--
-- Palette: folke/tokyonight.nvim "night" — same as the terminal (ghostty
-- built-in TokyoNight Night), editor (nvim), and tmux bar. Values are
-- literal here; every tool owns its colors next to its config.
--
-- Role mapping (role -> tokyonight source color):
--   BG/FG = bg/fg · BG_ALT = bg_dark · FG_MUTED = fg_dark (dim text)
--   BORDER/POPUP_BORDER/BG2 = fg_gutter (the canonical border color)
--   ACCENT = blue (signature) · ACCENT_2 = magenta (gradient partner)
--   ERROR/WARN = red1/yellow (folke's error/warning) · OK = green
--   hues map 1:1 · SAGE = green1 · ROSE = magenta2 · TEAL = teal
--   STEEL = dark5 · SHADOW = bg_dark1 · HIGHLIGHT = blue5 (selected-space
--   border — light, visible) · POPUP_BG = bg_dark (folke's bg_popup)
--   BAR_BORDER = bg_highlight (raised surface, as bar edge)
--
-- Shape is unchanged: every item/widget imports this table, so only the
-- values changed, not the API.
local r = {
	-- core
	BG = 0xff1a1b26,      -- window/pane background
	BG_ALT = 0xff16161e,  -- secondary surface
	FG = 0xffc0caf5,      -- primary text
	FG_MUTED = 0xffa9b1d6, -- dimmed text
	BORDER = 0xff3b4261,  -- dividers, pane borders
	ACCENT = 0xff7aa2f7,  -- the theme's signature color (blue)
	ACCENT_2 = 0xffbb9af7, -- gradient partner (magenta)
	-- status — thresholds and failures only, not syntax
	ERROR = 0xffdb4b4b,
	WARN = 0xffe0af68,
	OK = 0xff9ece6a,
	INFO = 0xff7aa2f7,
	-- hues
	RED = 0xfff7768e,
	GREEN = 0xff9ece6a,
	BLUE = 0xff7aa2f7,
	YELLOW = 0xffe0af68,
	ORANGE = 0xffff9e64,
	MAGENTA = 0xffbb9af7,
	CYAN = 0xff7dcfff,
	PURPLE = 0xff9d7cd8,
	SAGE = 0xff73daca,
	ROSE = 0xffff007c,
	GOLD = 0xffe0af68,
	PEACH = 0xffff9e64,
	TEAL = 0xff1abc9c,
	STEEL = 0xff737aa2,
	SHADOW = 0xff0C0E14,
	-- surfaces
	HIGHLIGHT = 0xff89ddff,
	BG2 = 0xff3b4261,
	BAR_BORDER = 0xff292e42,
	POPUP_BG = 0xff16161e,
	POPUP_BORDER = 0xff3b4261,
}

-- derived alpha layers (bar bg = BG at 80%, popup bg = 75%)
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
