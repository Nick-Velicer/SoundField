#!/bin/bash

file_name="output.csv"

source venvSetup.sh
source .venv/bin/activate

cd local

while true; do
  if [ -f "$file_name" ]; then
    echo "File found!"
    cd ../Sprints/Sprint12/CNN_SAE_DNN
    python prog.2.1.py
    cd ../../..
    cd local
    rm "$file_name"
  else
    echo "Waiting for file..."
    sleep 1
  fi
done