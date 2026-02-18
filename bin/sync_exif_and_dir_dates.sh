#!/bin/bash
#
# Recursively set image file creation/modification times from EXIF metadata,
# then set each directory’s creation/modification time to match
# the earliest file inside it (after EXIF correction).
#
# Usage:
#   ./sync_exif_and_dir_dates.sh /path/to/base/directory
#
# Requirements:
#   - exiftool (brew install exiftool)
#   - SetFile (included with macOS Xcode command line tools)
#

set -euo pipefail

BASE_DIR="${1:-.}"

if ! command -v exiftool >/dev/null 2>&1; then
  echo "Error: exiftool not found. Install with: brew install exiftool" >&2
  exit 1
fi

if ! command -v SetFile >/dev/null 2>&1; then
  echo "Error: SetFile not found. Install Xcode Command Line Tools: xcode-select --install" >&2
  exit 1
fi

echo "Processing base directory: $BASE_DIR"
echo

# Process each subdirectory recursively
find "$BASE_DIR" -type d -not -path .| while IFS= read -r dir; do
  echo "→ Processing directory: $dir"

  # Update file timestamps from EXIF data
  exiftool -overwrite_original \
    '-FileModifyDate<DateTimeOriginal' \
    '-FileCreateDate<DateTimeOriginal' \
    "$dir" >/dev/null 2>&1 || true

  # Find the earliest file (by creation time) in the directory
  first_file=$(find "$dir" -type f -not -path '*/\.*' -print0 | \
                xargs -0 stat -f '%B %N' 2>/dev/null | \
                sort -n | head -n1 | cut -d' ' -f2-)

  if [[ -n "$first_file" ]]; then
    # Get its creation time in YYYY-MM-DD HH:MM:SS format
    first_time=$(stat -f "%SB" -t "%m/%d/%Y %H:%M:%S" "$first_file")

    echo "   Setting directory timestamp to: $first_time (from $first_file)"
    # Update directory creation and modification times
    SetFile -d "$first_time" "$dir" 2>/dev/null || true
    SetFile -m "$first_time" "$dir" 2>/dev/null || true
  else
    echo "   (No files found in this directory)"
  fi

  echo
done

echo "✅ All done!"
