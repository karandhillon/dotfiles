-- Active theme: "sora" | "cendre"   (this line is rewritten by themify)
--
-- This module holds NO colors. Every value is read at runtime from
-- ~/.config/bin/themes/<theme>.conf — the single source of truth. The only
-- knowledge here is *shape*: which roles exist, and where alpha layers are
-- derived (bar bg = BG at 80%, popup bg = POPUP_BG at 75%).
local theme = "sora"

local REQUIRED = {
	"BG", "BG_ALT", "BG_SEL", "FG", "FG_MUTED", "BORDER", "ACCENT", "ACCENT_2",
	"ERROR", "WARN", "OK", "INFO",
	"RED", "GREEN", "BLUE", "YELLOW", "ORANGE", "MAGENTA", "CYAN", "PURPLE",
	"SAGE", "ROSE", "GOLD", "PEACH", "TEAL", "STEEL", "SHADOW",
	"HIGHLIGHT", "BG2", "BAR_BORDER", "POPUP_BG", "POPUP_BORDER",
}

local function read_roles(name)
	local path = os.getenv("HOME") .. "/.config/bin/themes/" .. name .. ".conf"
	local roles, f = {}, io.open(path, "r")
	if not f then
		error("colors.lua: themify conf not found: " .. path)
	end
	for line in f:lines() do
		local key, hex = line:match('^(%u[%u%d_]-)%s*=%s*"#(%x%x%x%x%x%x)"')
		if key then
			roles[key] = tonumber("0xff" .. hex)
		end
	end
	f:close()
	for _, k in ipairs(REQUIRED) do
		if not roles[k] then
			error("colors.lua: " .. name .. ".conf is missing color role: " .. k)
		end
	end
	return roles
end

local r = read_roles(theme)

-- derived alpha layers
local bar_bg = (r.BG & 0x00ffffff) | 0xcc000000 -- 80%
local popup_bg = (r.POPUP_BG & 0x00ffffff) | 0xc0000000 -- 75%

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
