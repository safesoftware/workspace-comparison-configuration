#!/bin/bash
# Arguments are: ancestor-file current-file other-file path
echo "Launching FMEWorkbench to merge " $4 

fmeworkbench -TITLE-OVERRIDE "[$4] Merge" -COMPARE-BASE $1 -COMPARE-BASE-TITLE "Base" -COMPARE-TITLE1 "Ours" -COMPARE-TITLE2 "Theirs" -COMPARE $2 $3
