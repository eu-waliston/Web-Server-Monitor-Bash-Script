#!/bin/bash

DB="../monitors.db"

URL=$1
EMAIL=$2
INTERVAL=${3:-60}

if [ -z "$URL" ] || [ -z "$EMAIL" ]; then
  echo "Uso: ./add_monitor.sh <url> <email> [intervalo_segundos]"
  exit 1
fi

sqlite3 $DB "
INSERT INTO monitors (url, email, interval)
VALUES ('$URL', '$EMAIL', $INTERVAL);
"

echo "Monitor adicionado: $URL"
