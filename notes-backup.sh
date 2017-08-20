#!/bin/bash

# destination folder
root=~/Dropbox/Backup/
dest=Notes-$(date +%Y-%m-%d)
full=${root}/${dest}
mkdir -p ${full}/

# first run export
echo "Running export of all notes"
osascript ./notes-export.scpt ${full}/

# now convert with iconv
echo "Fixing encoding issues"
for i in ${full}/*
do
  iconv -f macintosh -t utf-8 < "$i" > "$i.tmp"
  rm "$i"
  mv "$i.tmp" "$i"
done

# compressing
echo "Compressing archive"
tar -C ${root} -czf ${full}.tgz ${dest}/
rm -r ${full}/

# done
echo "Done!"
