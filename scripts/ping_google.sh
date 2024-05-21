#!/bin/bash

function ping_google() {
  local res=$(ping -c 1 1.1.1.1 2>/dev/null | rg time= | awk '{ print substr($7,6)}' | awk '{ print substr($1,1,5)}')

  if [ "$res" = "" ]; then
    echo "no internet"
  else
    echo "ping: $res"
  fi
}

ping_google
