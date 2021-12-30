#!/usr/bin/env bash

battery=$(upower -i $(upower -e | grep BAT))
echo $battery

if [ -z "$battery" ]
then
      echo "battery is not installed"
else
      echo "battery is installed"
fi