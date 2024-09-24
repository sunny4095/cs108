#!/bin/bash
# Read the roll number and marks of the exam to be updated
update() {
    read -p "Enter Student Name :" stu_name
    read -p "Enter Student Roll Number :" stu_roll
    read -p "Enter Exam Name :" exam
    read -p "Enter marks :" marks
    e="$exam"".csv"
    if [ -e "$e" ]; then 
    #update
        awk -F',' -v stu_roll="$stu_roll" -v marks="$marks" 'BEGIN{OFS=","} $1 == stu_roll {print $1, $2, marks; next} 1' "$e" > output.csv
        cat output.csv > "$e"
        rm -f output.csv
        echo "marks updated successfully"
    else
        echo "$exam does not exist"
    fi
}