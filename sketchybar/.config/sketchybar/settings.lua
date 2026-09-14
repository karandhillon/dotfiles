return {
	paddings = 3,
	group_paddings = 5,

	icons = "NerdFont", -- nerd glyphs render from icon.font (JetBrainsMono NF);
	-- sf-symbols only pairs with SF Pro fonts — mono text + sf icons broke

	-- JetBrainsMono Nerd Font (the plain variant, NOT Mono: a status bar
	-- is not a character grid — icons render at natural width). Matches
	-- the terminal (ghostty) typeface; installed via Brewfile cask.
	font = {
		text = "JetBrainsMono Nerd Font", -- Used for text
		numbers = "JetBrainsMono Nerd Font", -- Used for numbers
		style_map = {
			["Regular"] = "Regular",
			["Semibold"] = "Medium",
			["Bold"] = "SemiBold",
			["Heavy"] = "Bold",
			["Black"] = "ExtraBold",
		},
	},

	-- This is a font configuration for SF Pro and SF Mono (system fonts)
	-- font = require("helpers.default_font"),
}
