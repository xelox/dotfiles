#!/bin/bash

if [[ "$1" == "d" ]]; then
	ddccontrol -r 0x10 -W -10 dev:/dev/i2c-24
	ddccontrol -r 0x10 -W -10 dev:/dev/i2c-22

elif [[ "$1" == "i" ]]; then
	ddccontrol -r 0x10 -W +10 dev:/dev/i2c-24
	ddccontrol -r 0x10 -W +10 dev:/dev/i2c-22

elif [[ "$1" == "s" ]]; then -
	ddccontrol -r 0x10 -w $2 dev:/dev/i2c-24
	ddccontrol -r 0x10 -w $2 dev:/dev/i2c-22

elif [[ "$1" == "d1" ]]; then
	ddccontrol -r 0x10 -W -10 dev:/dev/i2c-22

elif [[ "$1" == "d2" ]]; then
	ddccontrol -r 0x10 -W -10 dev:/dev/i2c-24

elif [[ "$1" == "i1" ]]; then
	ddccontrol -r 0x10 -W +10 dev:/dev/i2c-22

elif [[ "$1" == "i2" ]]; then
	ddccontrol -r 0x10 -W +10 dev:/dev/i2c-24

elif [[ "$1" == "s1" ]]; then -
	ddccontrol -r 0x10 -w $2 dev:/dev/i2c-22

elif [[ "$1" == "s2" ]]; then -
	ddccontrol -r 0x10 -w $2 dev:/dev/i2c-24
else
	echo "Invalid option."
fi
