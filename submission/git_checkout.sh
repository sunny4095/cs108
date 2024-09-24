#!/bin/bash
git_checkout() {
    found=0
    hash=$1
    address_file="git_repo_address.txt"  #get repo_address
    repo_path="$(cat $address_file)"
    for dir in "$repo_path"/*;do   #scan the repository
        id=$(basename "$dir")  
        if [[ "$id" =~ ^$hash ]]; then
            found=1
            for file in ./*.csv;do  
                rm -f $file         #removing the csv files in present directory
            done
            for file in "$dir"/*.csv;do
                cp $file .          #updating the directory with csv files in the given commit
            done
        fi
    done
    if [ $found == 0 ];then
        echo "Error: No such commit with the given ID exists"
    else
        echo "Checked out to commit id $hash"
    fi
}