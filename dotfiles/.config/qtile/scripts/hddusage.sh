#!/bin/bash

# Simple script to show disk usage

disk="/"

free=$(df -h $disk | awk '/[0-9]%/{print $(NF-2)}')
used=$(df -h $disk | awk '/[0-9]%/{print $(NF-3)}')
total=$(df -h $disk | awk '/[0-9]%/{print $(NF-4)}')

printf "$used/$total"
