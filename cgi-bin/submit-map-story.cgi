#!/usr/bin/env bash

set -e

cd $DATA_REPOSITORY

data=$(cat)
hash=$(echo -n "$data" | sha256sum | awk '{print $1}')

if [ ! -e "$hash" ]; then
  cat > $hash <<<"$data"
  git config user.email admin@t17.lv
  git config user.name Submission
  git add "$hash"
  git commit -qam "New submission"
fi

echo Status: 302 Found
echo Location: ../lastadija/thanks.html
echo
