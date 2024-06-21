#!/bin/bash

# List of servers
servers=("pdc2rdftcebws01" "pdc2rdftcebws02" "pdc2rdftcebws03" "pdc2rdftcebws04" "pdc2rdftofxws01" "pdc2rdftofxws02" "pdc2rdftofxws03" "pdc2rdftcebws42" "pdc2rdftcebws43" "pdc2rdftcebws44" "pdc2rdftcebws45" "pdc2rdftcebws28" "pdc2rdftcebws29" "pdc2rdftcebws30" "pdc2rdftcebws31")

# CSV file to store the output
output_file="/path/to/server_status.csv"

# Write CSV header
echo "Server,Date,JVM_Status,Disk_Usage,Memory_Usage" > $output_file

# Function to get JVM status
get_jvm_status() {
    # Placeholder function: Replace with actual JVM status command
    echo "JVM_OK"
}

# Function to get disk usage
get_disk_usage() {
    df -h / | awk 'NR==2 {print $5}'
}

# Function to get memory usage
get_memory_usage() {
    free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2 }'
}

# Collect data from each server
for server in "${servers[@]}"; do
    jvm_status=$(ssh $server "$(typeset -f); get_jvm_status")
    disk_usage=$(ssh $server "$(typeset -f); get_disk_usage")
    memory_usage=$(ssh $server "$(typeset -f); get_memory_usage")
    echo "$server,$(date '+%Y-%m-%d %H:%M:%S'),$jvm_status,$disk_usage,$memory_usage" >> $output_file
done
