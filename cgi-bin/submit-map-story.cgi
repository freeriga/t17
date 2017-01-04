#!/usr/bin/env bash

set -e

if [[ $REQUEST_METHOD != POST || $CONTENT_LENGTH < 0 ]]; then
  echo Status: 400 Bad Request
  echo
  echo Bad request.
  exit
fi

read -n "$CONTENT_LENGTH" data

param() {
  perl -mCGI -e 'print scalar CGI->new($ARGV[0])->param($ARGV[1])' "$data" "$1"
}

desc="## Name
$(param place-name)

## Address
$(param address)

## Contact
$(param contact)

## Contact name
$(param contact-name)

## Snippet
$(param short-story)

## Story
$(param full-story)"

cd $DATA_REPOSITORY

hash=$(echo -n "$data" | sha256sum | awk '{print $1}')

if [ ! -e "$hash" ]; then
  cat > $hash <<<"$data"
  git config user.email admin@t17.lv
  git config user.name Submission
  git add "$hash"
  git commit -qam "New submission"
fi

curl -sS \
  --data-urlencode "name=$(param place-name)" --data-urlencode "desc=$desc" \
  --data "idList=$TRELLO_LIST&token=$TRELLO_TOKEN&key=$TRELLO_KEY" \
  https://api.trello.com/1/cards

echo Status: 302 Found
echo Location: ../lastadija
echo
