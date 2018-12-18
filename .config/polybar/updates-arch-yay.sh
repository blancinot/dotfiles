#!/bin/sh
# List all updates available from Yay (includes AUR)

# Sync package list first
yay -Sy > /dev/null

# Get list and count of updates
if ! updates=$(yay -Qu | wc -l); then
    updates=0
fi

echo "   $updates "
