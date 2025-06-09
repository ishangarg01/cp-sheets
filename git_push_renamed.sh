#!/bin/bash

# Usage:
# ./git_push_renamed.sh actual_filename [as new_filename]

if [ "$#" -eq 1 ]; then
    # Just one argument, push the file as is
    ORIGINAL_FILE="$1"

    if [ ! -f "$ORIGINAL_FILE" ]; then
        echo "Error: File '$ORIGINAL_FILE' does not exist."
        exit 1
    fi

    git add "$ORIGINAL_FILE"
    git commit --allow-empty-message -m ""
    git push origin main

    echo "Done: '$ORIGINAL_FILE' pushed as itself."

elif [ "$#" -eq 3 ] && [ "$2" == "as" ]; then
    ORIGINAL_FILE="$1"
    RENAMED_FILE="$3"

    if [ ! -f "$ORIGINAL_FILE" ]; then
        echo "Error: File '$ORIGINAL_FILE' does not exist."
        exit 1
    fi

    cp "$ORIGINAL_FILE" "$RENAMED_FILE"
    git add "$RENAMED_FILE"
    git commit --allow-empty-message -m ""
    git push origin main
    rm "$RENAMED_FILE"

    echo "Done: '$ORIGINAL_FILE' pushed as '$RENAMED_FILE' and cleaned up locally."

else
    echo "Usage:"
    echo "  $0 <file>"
    echo "  $0 <file> as <new_name>"
    exit 1
fi
