#!/usr/bin/env bash
set -ex
export WEBDRIVER_BROWSER=firefox
export WEBDRIVER_SESSION=$(wd new-session)
for x in stasts/*; do
  wd go http://localhost:3000/lastadija/$x/banner.html
  sleep 0.5
  rm $x/*.png
  wd screenshot > $x/banner.png
  mogrify -crop 1200x630+0+0 $x/banner.png
done
