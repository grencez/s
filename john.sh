#!/bin/sh

cmd="$HOME/local/opt/john/run/john"
alias expr='expr >/dev/null'

file=""
for arg in "$@"
do
  if ! expr "$arg" : "^-"
  then
    file=$arg
  fi
done

if [ "$file" ]
then
  exec $cmd --session="$file" --pot="${file}.pot" "$@"
else
  exec $cmd "$@"
fi

