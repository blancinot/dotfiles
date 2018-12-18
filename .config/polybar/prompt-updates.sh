#! /bin/bash
ALL=$(yay -Qu | sed 's/\x1b\[[0-9;]*m//g' | sed 's/->//g' | sed 's/^/TRUE /g')
UPDATES=$(zenity --list \
  --width=500 --height=400 \
  --text="Packages to update:" \
  --separator=" " \
  --title="The following packages are outdated" \
  --checklist \
  --column "Pick" --column="Package Name" --column="Previous Version" --column="Current Version" \
  $ALL)

if [[ -z "${UPDATES// }" ]]
then
    exit 1
else
    urxvt -title "Upgrade packages" -e bash -c "echo \"Upgrade packages: $UPDATES\" && yay -Syu $UPDATES"
fi
