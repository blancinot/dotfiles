#!/bin/sh
# List all updates available from Yay (includes AUR)

# Sync package list first
sudo yay -Sy > /dev/null 2>&1

# Get list and count of updates
if ! updates=$(yay -Qu | wc -l); then
    updates=0
fi

echo "   $updates "
