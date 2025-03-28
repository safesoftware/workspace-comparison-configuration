#!/bin/bash
# Arguments are: ancestor-file current-file other-file path
echo "Launching FMEWorkbench to merge " $4 

# As of FME 2025.0, workspace comparison MUST be done on files that end either in .fmx or .fmw. 
# The temporary files that git creates are in either of these extensions, so we need to create 
# our own temporary files that have the proper extension depending on if the file we're attempting 
# to resolve merge conflcits for is .fmx or .fmw. Then after we use finish our merge we copy the 
# content back into the temporary files git is expecting to be updated
extension=".${4##*.}"

ancestor_temp=$(mktemp --suffix="$extension")
current_temp=$(mktemp --suffix="$extension")
other_temp=$(mktemp --suffix="$extension")
result_temp=$(mktemp --suffix="$extension")

cp "$1" "$ancestor_temp"
cp "$2" "$current_temp"
cp "$3" "$other_temp"

fmeworkbench -TITLE-OVERRIDE "[$4] Merge" \
   -COMPARE-BASE "$ancestor_temp" -COMPARE-BASE-TITLE "Base" \
   -COMPARE-TITLE1 "Ours" -COMPARE-TITLE2 "Theirs" \
   -COMPARE "$current_temp" "$other_temp" \
   -MERGE-OUTPUT "$result_temp"

merge_status=$?

if [ "$merge_status" -eq 0 ]; then
   cp "$result_temp" "$2"
   echo "Merge completed successfully."
else
   echo "Merge conflict unresolved."
fi

rm -f "$ancestor_temp" "$current_temp" "$other_temp" "$result_temp"

exit $merge_status
