#!/bin/bash

source ~/.config/systemd/user/.secret.sh

WATCH_DIR="/home/Naga/Obsidian"        # Локальная папка Obsidian

inotifywait -m -r -e modify,create,delete,move "$WATCH_DIR" --format '%w%f' |
while read FILE
do
  echo "Detected change in $FILE"
  rsync -az --delete -e "ssh -p $REMOTE_PORT" "$WATCH_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
done
