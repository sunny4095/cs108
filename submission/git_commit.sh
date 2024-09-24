#!/bin/bash
# I am storing the commits by making another directory in the git repo which then stores the csv files
git_commit () {
    local repo_path=$1
    local commit_message=$2
    rand_1=$(($RANDOM % 10))
    rand_2=$(($RANDOM % 10))
    rand_3=$(($RANDOM % 10))
    rand_4=$(($RANDOM % 10))
    rand_5=$(($RANDOM % 10))
    rand_6=$(($RANDOM % 10))
    rand_8=$(($RANDOM % 10))
    rand_9=$(($RANDOM % 10))
    rand_11=$(($RANDOM % 10))
    rand_12=$(($RANDOM % 10))
    rand_13=$(($RANDOM % 10))
    rand_14=$(($RANDOM % 10))
    rand_15=$(($RANDOM % 10))
    rand_16=$(($RANDOM % 10))
    # hash is the random 16 digit commit id
    hash="$rand_1""$rand_2""$rand_3""$rand_3""$rand_4""$rand_5""$rand_6""$rand_7""$rand_8""$rand_9""$rand_10""$rand_11""$rand_12""$rand_12""$rand_13""$rand_14""$rand_15""$rand_16"
    new_file="$repo_path""/""$hash"",""$commit_message" #storing the commit as "<commit-id>,<commit-message>"
    mkdir "$new_file"
    for file in ./*.csv
    do
        cp $file $new_file  #copying the files to the commit directory
    done

}