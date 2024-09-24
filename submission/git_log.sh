#!/bin/bash
git_log() {
    if [ -e git_repo_address.txt ]; then
        address_file="git_repo_address.txt"
        repo_path="$(cat $address_file)"
        file_count=$(ls -A "$repo_path" | wc -l) #counting number of commits
        if [ "$file_count" -eq 0 ]; then
            echo "No commits have been done"
        else
            for file in "$repo_path"/*; do
                IFS=','
                read -ra arr <<< "$file" #spliting the name of the commit directory as "commit-id" and "commit-message" and storing them in an array
                id=$(basename "${arr[0]}") 
                echo "commit id : $id"
                echo "commit message : ${arr[1]}"
                echo ""
            done
        fi
    fi
}