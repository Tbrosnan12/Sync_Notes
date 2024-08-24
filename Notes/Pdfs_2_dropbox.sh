#!/bin/bash

dir=$HOME/Documents/TP_notes
dropbox=$HOME/Dropbox/TP_notes

ignore_list=("Tex_files" "README.md")

cd $dir
for file in *; do
    if [[ ! " ${ignore_list[@]} " =~ " ${file} " ]]; then
        rm -rf "$dropbox/$file" && cp -r "$file" "$dropbox/$file"
    fi
done