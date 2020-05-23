#!/bin/bash
#OS detect
osdetect=$(uname)
file_path="unknown"
if [[ "$osdetect" == 'Darwin' ]]; then
  file_path="rm /Library/Fonts/"
elif [[ "$osdetect" == 'Linux' ]]; then
  if [[ -d /usr/local/share/fonts/ ]]; then # Debian/Ubuntu and others.
    file_path="sudo rm /usr/local/share/fonts/"
  elif [[ -d /usr/share/fonts/ ]]; then # OpenSUSE, Arch and other distros using this directory structure
    file_path="sudo rm /usr/share/fonts/google/"
  else # Fallback to installing fonts locally to the user, this is a safe bet, as several distros use this location.
    file_path="rm ~/.fonts/"
  fi
fi

clear
echo "Un-Installing all Google Web Fonts onto your System"
echo "Downloading font list..."
cd /tmp/

curl -L https://raw.githubusercontent.com/macwinrepo/googlefonts/list-of-fonts.txt -o list-of-fonts.txt

while read font; do
  $file_path$font
done <list-of-fonts.txt

rm -rf list-of-fonts.txt
echo "All done! All Google Web Fonts removed."
