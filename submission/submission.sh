#!/bin/bash

# BASH GRADER by
# Shashank (23B1040)
#---------------------------------------------------------------------------------------------


source ./combine.sh
source ./upload.sh
source ./git_commit.sh
source ./update.sh
source ./git_log.sh
source ./git_checkout.sh


command="$1"

# The script runs/calls other scripts based on the command recieved 

if [ "$command" == "menu" ]; then
    echo ""
    echo "Hi! This is my bash grader created as a part of CS108 course" 
    echo "Here you can see the commands I've created and what they do"
    echo "------------------------------------------------------------"
    echo "->bash submission.sh combine"
    echo "It combines all the csv files in the present directory and produces a main.csv"
    echo ""
    echo "->bash submission.sh upload <path-to-file> "
    echo "It copies the given csv file to the present directory"
    echo ""
    echo "->bash submission.sh total"
    echo "It appends a column 'total' to the main.csv which is the total of all the exam's marks"
    echo ""
    echo "->bash submission.sh git_init <path-to-repository>"
    echo "it just creates a directory in the provided path which will be used to store all the commits"
    echo ""
    echo "->bash submission.sh git_commit <commit-message>"
    echo "It copies all the csv files into the git repo initialized through git_init command"
    echo ""
    echo "->bash submission.sh git_checkout <commit-id>"
    echo "It reverts all the csv files to versions of the commit id provided"
    echo ""
    echo "->bash submission.sh git_log"
    echo "Provides the history of all the commits along with their commit messages"
    echo ""
    echo "->bash submission.sh update"
    echo "It asks the student's roll number, the exam name and marks and updates the corresponding entry with the given marks"
    echo ""
    echo "->bash submission.sh exam_stats"
    echo "It asks the exam name and returns the mean, median and standard deviation of the results along with a plot of number of students vs marks"
    echo ""
    echo "->bash submission.sh student_stats"
    echo "It asks the student's roll number and returns a bar graph of percentiles of that student in each exam"
    echo ""
    echo "-----------------------------------------------------------------------------------"
    echo ""



fi

if [ "$command" == "combine" ]; then
    combine #calling the combine script
fi

if [ "$command" == "upload" ]; then
    upload $2 #calling the upload script
fi

if [ "$command" == "total" ]; then
    if [ -e main.csv ]; then 
        #calling the awk scrpit
        awk -f total.awk main.csv > output.csv
        cat output.csv > main.csv
        rm -f output.csv
    else
        echo "ERROR : main.csv does not exist"
    fi
fi

if [ "$command" == "update" ]; then 
    update #calling the update script
fi

if [ "$command" == "git_init" ]; then 
    
    path=$2
    if [ -e "$path" ]; then
        echo "ERROR : File already exists"
    else 
    # storing the repo address in a txt file so it can be accessed later
        mkdir "$path"                         
        echo "$path" > git_repo_address.txt
        echo "successfully initialized git reposiory in path $2"
    fi
fi

if [ "$command" == "git_commit" ]; then
    if [ -e git_repo_address.txt ]; then
        address_file="git_repo_address.txt"
        repo_path="$(cat $address_file)"
        git_commit $repo_path $2 #calling the git_commmit script
    else 
        echo "ERROR : a git repository has not been initialized"
    fi
fi

if [ "$command" == "git_log" ]; then
    git_log # calling the git log script
fi
    
if [ "$command" == "exam_stats" ]; then 
    read -p "Enter the exam name : " exam_name
    exam="$exam_name"".csv"
    if [ -e "$exam" ]; then 
        python3 stats.py "$exam" #calling the stats.py script
    else
        echo "$exam does not exist"
    fi
fi

if [ "$command" == "git_checkout" ]; then
    git_checkout $2 #calling the git_checkout script
fi

if [ "$command" == "student_stats" ];then 
    read -p "Enter student's roll number: " stu_roll_num
    if [ -e main.csv ];then 
        python3 student_stats.py "$stu_roll_num" #calling the student_stats.py script
    else
        echo "Error: main.csv need to exist to show the students stats"
        echo "Please combine the files first"
    fi
fi

if [ "$command" != "menu" ] && [ "$command" != "update" ] && [ "$command" != "git_checkout" ] && [ "$command" != "git_log" ] && [ "$command" != "git_init" ] && [ "$command" != "git_commit" ] && [ "$command" != "upload" ] && [ "$command" != "combine" ] && [ "$command" != "exam_stats" ] && [ "$command" != "student_stats" ] ;then
    echo "Error: Invalid command"
    echo "Please see the menu for more information"
fi

    
            
            



