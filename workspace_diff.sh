#!/bin/bash
# Arguments are: path old-file old-hex old-mode new-file new-hex new-mode

echo "Comparing changes on '" $1 "' using FME Workspace Compare"

# Surpress Qt log messages to avoid adding noise in users workflow
export QT_LOGGING_RULES="*=false"

fmeworkbench -TITLE-OVERRIDE "[$1] Compare Changes" \
   -COMPARE-TITLE1 "Left" -COMPARE-TITLE2 "Right" \
   -COMPARE $5 $2

exit 0
