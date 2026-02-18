#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Hot Corners
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Mark Horlbeck

# Path to preferences
PREFS="com.apple.dock"

# Corner key names
corners=("tl" "tr" "bl" "br")

# Action codes:
#  0 = no-op
#  2 = Mission Control
#  3 = Application Windows
#  4 = Desktop
#  5 = Start Screen Saver
#  6 = Disable Screen Saver
# 10 = Lock Screen
# 11 = Launchpad
# You can customize these.

# Simulate key-value pairs
hotcorner_keys=(tl tr bl br)
hotcorner_values=(2 3 0 4)

# Function to get value by key
get_hotcorner_action() {
  local key="$1"
  for i in "${!hotcorner_keys[@]}"; do
    if [[ "${hotcorner_keys[$i]}" == "$key" ]]; then
      echo "${hotcorner_values[$i]}"
      return
    fi
  done
  echo "Key not found: $key" >&2
  return 1
}

# Check current top-left corner state
current=$(defaults read $PREFS wvous-tl-corner)

if [[ "$current" -eq 0 ]]; then
  echo "Enabling Hot Corners..."
  for corner in "${corners[@]}"; do
    code=$(get_hotcorner_action "${corner}")
    defaults write $PREFS wvous-${corner}-corner -int "$code"
    defaults write $PREFS wvous-${corner}-modifier -int 0
  done
else
  echo "Disabling Hot Corners..."
  for corner in "${corners[@]}"; do
    defaults write $PREFS wvous-${corner}-corner -int 0
    defaults write $PREFS wvous-${corner}-modifier -int 0
  done
fi

# Apply changes
killall Dock
