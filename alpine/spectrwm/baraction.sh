#! /bin/sh

while :; do
	 echo -e "B @ $(cat /sys/class/power_supply/BAT0/capacity)%; V @ $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"
        sleep .5
done
