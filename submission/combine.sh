#!/bin/bash
combine() {
    if [ -e "./main.csv" ]; then 
        rm -f main.csv
    fi
    
    I=0
    declare -A myarr
    declare -a name_arr  

# Read every csv file in the directory line by line and store it in an array

    for file in *.csv; do
        file_name="${file%.*}"
        name_arr[$I]=$file_name 
        j=0
        IFS=','
        RS='\r'
        while read -r -a line; do
            myarr[$I,$j,0]=${line[0]}
            myarr[$I,$j,1]=${line[1]}
            myarr[$I,$j,2]=$(echo ${line[2]} | tr -d \r)
            ((j++))
        done < "$file"
        ((I++))
    done

# create the header of the main.csv    
    touch main.csv
    header="Roll_Number,Name"
    for name in "${name_arr[@]}"; do
        header="$header,$name"
    done
    echo "$header" > main.csv  
    
    declare -A roll_name_map
    declare -A roll_marks_map

# Creating an array which takes in the roll number as index and stores the name of the student

    for ((i=0; i<$I; i++)); do
        num_elements=0
        for index in "${!myarr[@]}"; do
            if [[ "$index" =~ ^$i,[0-9],0 ]]; then
                ((num_elements++))
            fi
        done
        for ((j=1; j<num_elements; j++)); do
            roll_name_map["${myarr[$i,$j,0]}"]="${myarr[$i,$j,1]}"
            
        done
    done

# Creating an array which has roll number and exam number as index and stores the marks in that exam

    for roll_num in "${!roll_name_map[@]}"; do
        for ((i=0; i<I; i++)); do
            num_elements=0
            for index in "${!myarr[@]}"; do
                if [[ "$index" =~ ^$i,[0-9]+,0 ]]; then
                ((num_elements++))
                fi
            done
            found=0
            for ((j=1; j<num_elements; j++)); do
                if [ "$roll_num" == "${myarr[$i,$j,0]}" ]; then
                    roll_marks_map["$roll_num,$i"]="${myarr[$i,$j,2]}"
                    found=1
                fi
            done
            if [ "$found" == "0" ]; then
                roll_marks_map["$roll_num,$i"]=a
            fi
        done
    done

# Appending the enteries into main.csv

    for roll_num in "${!roll_name_map[@]}"; do
        row="$roll_num,${roll_name_map[$roll_num]}"
        K=""
        for ((i=0; i<I; i++)); do
            Z="$(echo "${roll_marks_map["$roll_num,$i"]}")"
            K=$K,$Z
            
        done
        echo "$row$K" >> main.csv
    done 
}  
