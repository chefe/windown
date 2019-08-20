#!/bin/sh
link=$(python3 ./get-win10-iso-url.py)
if [ "$?" -eq "0" ]; then
    curl "$link" -o win.iso
else
    echo "Failed to generate download link!"
    exit 1
fi
