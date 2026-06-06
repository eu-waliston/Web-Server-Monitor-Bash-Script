#!/bin/bash

DB="../monitors.db"
LOG="../checks.log"

check_url() {
  URL=$1

  for i in {1..3}; do
    HTTP=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$URL")

    if [ "$HTTP" -eq 200 ]; then
      echo "UP"
      return
    fi

    sleep 2
  done

  echo "DOWN"
}

while true; do
  NOW=$(date +%s)

  sqlite3 $DB "SELECT id, url, email, interval, status, last_check FROM monitors;" | while IFS='|' read ID URL EMAIL INTERVAL STATUS LAST_CHECK
  do
    DIFF=$((NOW - LAST_CHECK))

    if [ $DIFF -ge $INTERVAL ]; then

      NEW_STATUS=$(check_url "$URL")

      echo "$(date) | $URL | $NEW_STATUS" >> $LOG

      if [ "$NEW_STATUS" != "$STATUS" ]; then
        bash notify.sh "$EMAIL" "$URL" "$NEW_STATUS"
      fi

      sqlite3 $DB "
        UPDATE monitors
        SET status='$NEW_STATUS', last_check=$NOW
        WHERE id=$ID;
      "
    fi

  done

  sleep 10
done
