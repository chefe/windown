#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: ${0##*/} [VERSION]"
  echo "Download the windows iso for the given version."
  echo ""
  echo "Currently only version 10 and 11 are supported."
  echo ""
  echo "Examples:"
  echo "  download.sh 10      Download win10.iso"
  echo "  download.sh 11      Download win11.iso"
  exit 1
fi

if [ "$1" -ne 10 ] && [ "$1" -ne 11 ]; then
    echo "Invalid version provided! Use 10 or 11."
    exit 1
fi

echo "\033[0;32m=> Generating download link\033[0m"
link="$(python3 ./get-win-iso-url.py "$1")"
if [ "$?" -ne "0" ]; then
    echo "\033[0;31mFailed to generate download link!\033[0m"
    exit 1
fi

echo "\033[0;32m=> Download iso\033[0m"
curl "$link" -o "win${1}.iso"

echo "\033[0;32m=> Done\033[0m"

