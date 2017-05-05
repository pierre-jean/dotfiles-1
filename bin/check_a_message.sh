#!/bin/bash

if [ $# -ne 2 ]; then
    echo "You need to provide 2 params: Usage: ./check_a_message.sh <queue name> <thing to look for>"
    exit 1
fi

tempDir=$(mktemp -d)
aws s3 sync s3://sap-messages-test/$1/ $tempDir
numberOfMatchs=$(grep -r $2 $tempDir | wc -l)

if [ $numberOfMatchs -gt 0 ]; then
    echo "Received"
else
    echo "Not received"
fi
rm -rf $tempDir