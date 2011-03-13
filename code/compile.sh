#!/bin/bash
while [ 1 ]
do
  # clear
  echo -n "compiling... "
  coffee -o gen -c Compiler.coffee &&
    coffee -o gen --compile app &&
    echo ok &&
    sleep 1
done

