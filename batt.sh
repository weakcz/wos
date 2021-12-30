#!/usr/bin/env bash

battery=$(upower -i $(upower -e | grep BAT))


if [ -n "$battery" ]
then
      echo "battery is installed"
else
      echo "battery is not installed"
fi