#!/bin/bash
if [ $1 = "server" ]; then
  js-shell -e "`coffee -p code/Compiler.coffee code/app 2>&1`; js.compile()"
elif [ $1 = "client" ]; then
  coffee -p code/Compiler.coffee code/app 2>&1
  echo "js.compile()"
else
  echo "Please supply compile mode: 'client' or 'server'."
fi
