#!/bin/bash

basedir="/sys/class/backlight/"
handler=$basedir$(ls $basedir)"/"
old_brightness=$(cat $handler"brightness")
max_brightness=$(cat $handler"max_brightness")
old_brightness_p=$(( 100 * $old_brightness / $max_brightness ))
new_brightness_p=$(( $old_brightness_p $1 ))
new_brightness=$(( $max_brightness * $new_brightness_p / 100 ))
echo $new_brightness > $handler"brightness"

