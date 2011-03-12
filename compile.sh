#!/bin/bash
while [ 1 ]
do
  clear
  echo -n "compiling... "
  coffee -c loader/loader.coffee &&
    coffee -o gen --compile code &&
    echo ok &&
    sleep 1 || read
done

