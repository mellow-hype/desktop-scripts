#!/bin/sh
intern="eDP-1"
extern="DP-3"
extern_res="5120x1440"
xrandr --output "$intern" --off --output "$extern" --mode "$extern_res"