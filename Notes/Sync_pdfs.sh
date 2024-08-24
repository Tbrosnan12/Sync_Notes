#!/bin/bash

repo_dir=$HOME/Documents/TP_notes/

Years=("Third_year" "Fourth_year")
Semesters=("First_semester" "Second_semester")

cd ${repo_dir}/Tex_files

for year in "${Years[@]}"; do
    cd $year
    for semester in "${Semesters[@]}"; do
        cd $semester
        if [ "$(ls -A)" ]; then 
            for subject in *; do
                cd $subject
                cp *.pdf ${repo_dir}/$year/$semester/${subject}.pdf
                cd ..
            done
        fi
        cd ..
    done
    cd ..
done