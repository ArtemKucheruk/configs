#!/bin/bash

EVENT=$(osascript 2>/dev/null <<'APPLESCRIPT'
tell application "System Events"
  tell process "Notion Calendar"
    try
      set statusItems to every menu bar item of menu bar 2
      repeat with sbi in statusItems
        set t to title of sbi
        if t is not missing value and t is not "" then
          return t
        end if
      end repeat
    end try
    return ""
  end tell
end tell
APPLESCRIPT
)

if [ -z "$EVENT" ]; then
  sketchybar --set "$NAME" label="No events" icon.color=0xff6c7086
else
  sketchybar --set "$NAME" label="$EVENT" icon.color=0xffffffff
fi
