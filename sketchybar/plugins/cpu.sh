#!/bin/bash

CPU=$(top -l 1 -s 0 -n 0 | awk '/CPU usage/ {print $3}' | tr -d '%')
sketchybar --set "$NAME" label="${CPU}%"
