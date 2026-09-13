local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	position = "top",
	height = 40,
	color = colors.bar.bg,
	padding_right = 0,
	padding_left = 0,
	corner_radius = 0,
	margin = 0,
	sticky = "on",
	y_offset = 0,
	shadow = false,
	blur_radius = 30,
})
