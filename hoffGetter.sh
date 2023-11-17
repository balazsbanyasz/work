#!/bin/bash
rand=$((1 + $RANDOM % 4))
user=$(whoami)
curl -O "https://raw.githubusercontent.com/balazsbanyasz/work/main/hoff$rand.png"
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"Users/$user/Downloads/hoff2.png\" as POSIX file"
