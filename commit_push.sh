#!/bin/bash

# loop over all files recursively
find . -type f | while read file; do
    echo "Adding and pushing $file ..."
    git add "$file"
    git commit -m "Add $file"
    git push origin main
done