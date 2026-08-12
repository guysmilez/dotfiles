#!/bin/bash

while true; do
  CALL_STATUS=$(osascript <<EOF
tell application "System Events"
  set isRunning to exists (processes where name is "Microsoft Teams WebView")
  if not isRunning then
    return "teams_not_running"
  end if
  if isRunning then
    set micStatus to do shell script "/Users/mhorlbeck/Code/dotfiles/bin/micstatus"
    if micStatus is "true" then
      return "in_call"
    end if
  end if
end tell
return "not_in_call"
EOF
)

CLI='/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli'

if [ "$CALL_STATUS" = "in_call" ]; then
  "$CLI" --set-variables '{"teams_call_active": 1}'
else
  "$CLI" --set-variables '{"teams_call_active": 0}'
fi

sleep 5
done
