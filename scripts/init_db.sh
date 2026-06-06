#!/bin/bash

DB="../monitors.db"

sqlite3 $DB <<EOF
CREATE TABLE IF NOT EXISTS monitors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  url TEXT NOT NULL,
  email TEXT NOT NULL,
  interval INTEGER DEFAULT 60,
  status TEXT DEFAULT 'UNKNOWN',
  last_check INTEGER DEFAULT 0
);
EOF

echo "Banco inicializado com sucesso!"
