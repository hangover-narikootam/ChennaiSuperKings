#!/bin/bash

# CSV file path
csv_file="/path/to/server_status.csv"
# HTML output file path
html_file="/path/to/dashboard.html"

# Generate HTML header
cat <<EOL > $html_file
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Dashboard</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<h1>Server Dashboard</h1>
<table>
    <thead>
        <tr>
            <th>Server</th>
            <th>Date</th>
            <th>JVM Status</th>
            <th>Disk Usage</th>
            <th>Memory Usage</th>
        </tr>
    </thead>
    <tbody>
EOL

# Parse CSV and generate HTML rows
tail -n +2 $csv_file | while IFS=, read -r server date jvm_status disk_usage memory_usage; do
    cat <<EOL >> $html_file
        <tr>
            <td>$server</td>
            <td>$date</td>
            <td>$jvm_status</td>
            <td>$disk_usage</td>
            <td>$memory_usage</td>
        </tr>
EOL
done

# Generate HTML footer
cat <<EOL >> $html_file
    </tbody>
</table>
</body>
</html>
EOL
