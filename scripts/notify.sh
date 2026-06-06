#!/bin/bash

EMAIL=$1
URL=$2
STATUS=$3

MSG="$URL is $STATUS at $(date)"

echo "$MSG" >> ../alerts.log

echo "$MSG" | mail -s "Monitor Alert: $STATUS" "$EMAIL"
