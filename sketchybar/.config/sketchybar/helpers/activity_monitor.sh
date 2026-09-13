#!/bin/sh
# Open Activity Monitor and select a tab by name: cpu|memory|energy|disk|network
TAB="$1"
osascript - "$TAB" <<'EOF'
on run argv
	set tabName to item 1 of argv
	tell application "Activity Monitor"
		activate
		reopen
	end tell
	delay 0.5
	tell application "System Events"
		tell process "Activity Monitor"
			repeat with w in windows
				if name of w starts with "Activity Monitor" then
					set rbs to every radio button of radio group 1 of group 1 of toolbar 1 of w
					repeat with rb in rbs
						if description of rb is tabName then
							click rb
							return
						end if
					end repeat
				end if
			end repeat
		end tell
	end tell
end run
EOF
