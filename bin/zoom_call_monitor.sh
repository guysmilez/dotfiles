#!/bin/bash

while true; do
  ZOOM_STATUS=$(osascript <<EOF
tell application "System Events"
  set zoomRunning to exists (processes where name is "zoom.us")
  if not zoomRunning then
    return "zoom_not_running"
  end if
  if zoomRunning then
    tell process "zoom.us"
      if exists menu item "Copy invite link" of menu 1 of menu bar item "Meeting" of menu bar 1 then
        return "in_call"
      end if
    end tell
  end if
end tell
return "not_in_call"
EOF
)

CLI='/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli'

if [ "$ZOOM_STATUS" = "in_call" ]; then
  "$CLI" --set-variables '{"zoom_call_active": 1}'
else
  "$CLI" --set-variables '{"zoom_call_active": 0}'
fi

sleep 5
done
