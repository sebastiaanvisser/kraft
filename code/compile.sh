#!/bin/bash
if [ $1 = "server" ]; then
  js-shell -e "`/usr/local/bin/node /usr/local/bin/coffee -p code/Compiler.coffee code/app 2>&1`; js.compile()"
elif [ $1 = "client" ]; then
  /usr/local/bin/node /usr/local/bin/coffee -p code/Compiler.coffee code/app 2>&1
  echo "js.compile()"
else
  echo "Please supply compile mode: 'client' or 'server'."
fi
