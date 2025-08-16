#!/bin/bash

BATCH_SIZE=10  # number of files per commit
count=0
files_to_add=()

# loop over all files recursively, skipping .git
find . -type f ! -path "./.git/*" | while read file; do
    files_to_add+=("$file")
    ((count++))

    if [ $count -ge $BATCH_SIZE ]; then
        echo "Adding and committing batch of $BATCH_SIZE files ..."
        git add "${files_to_add[@]}"
        git commit -m "Add batch of $BATCH_SIZE files"
        git push origin main
        # reset for next batch
        files_to_add=()
        count=0
    fi
done

# commit any remaining files
if [ $count -gt 0 ]; then
    echo "Adding and committing final batch of $count files ..."
    git add "${files_to_add[@]}"
    git commit -m "Add final batch of $count files"
    git push origin main
fi
