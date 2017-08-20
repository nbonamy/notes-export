#!/bin/bash

# destination folder
dest=~/Dropbox/Backup/Notes-$(date +%Y-%m-%d)
mkdir -p ${dest}/

# first run export
echo "Running export of all notes"
osascript ./notes-export.scpt ${dest}/

# now convert with iconv
echo "Fixing encoding issues"
for i in ${dest}/*
do
  iconv -f macintosh -t utf-8 < "$i" > "$i.tmp"
  rm "$i"
  mv "$i.tmp" "$i"
done

# compressing
echo "Compressing archive"
tar -C $(dirname ${dest}) -czf ${dest}.tgz $(basename ${dest})/
rm -r ${dest}/

# done
echo "Done!"
