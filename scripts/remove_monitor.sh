#!/bin/bash

DB="../monitors.db"

ID=$1

if [ -z "$ID" ]; then
  echo "Uso: ./remove_monitor.sh <id>"
  exit 1
fi

sqlite3 $DB "DELETE FROM monitors WHERE id=$ID;"

echo "Monitor removido: ID $ID"
