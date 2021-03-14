#!/bin/sh
xrandr --output DisplayPort-0 --primary --mode 3840x1600 --pos 0x526 --rotate normal --output DisplayPort-1 --mode 2560x1440 --pos 3840x0 --rotate left --output DisplayPort-2 --off --output HDMI-A-0 --off
nitrogen --restore
