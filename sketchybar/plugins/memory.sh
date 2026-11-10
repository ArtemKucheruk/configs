#!/bin/bash

PAGE_SIZE=$(pagesize)
read ACTIVE WIRED <<< $(vm_stat | awk '
  /Pages active/ { gsub(/\./, "", $3); active=$3 }
  /Pages wired/  { gsub(/\./, "", $4); wired=$4 }
  END { print active, wired }
')
MEM_GB=$(( (ACTIVE + WIRED) * PAGE_SIZE / 1024 / 1024 / 1024 ))
sketchybar --set "$NAME" label="${MEM_GB}G"
