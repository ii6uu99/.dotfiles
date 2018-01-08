#!/bin/sh
## Description: Create new optimized modes for fullscreen and maximized VNC window, add them, and set minimal Hi-Res mode as current. Configured for VNC by default.

## HOW TO USE:
# curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-hi-res-optimized.sh | sh /dev/stdin


# FULLSCREEN
## 1920x1080 59.96 Hz (CVT 2.07M9) hsync: 67.16 kHz; pclk: 173.00 MHz
# Modeline "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-echo-newmode.sh | sh -x /dev/stdin 1920 1080

# VNC WINDOW MAXIMIZED
## 1920x1010 59.92 Hz (CVT) hsync: 62.79 kHz; pclk: 160.75 MHz
# Modeline "1920x1010_60.00"  160.75  1920 2040 2240 2560  1010 1013 1023 1048 -hsync +vsync
curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-echo-newmode.sh | sh -x /dev/stdin 1920 1010

# FULLSCREEN
## 2560x1440 59.96 Hz (CVT 3.69M9) hsync: 89.52 kHz; pclk: 312.25 MHz
# Modeline "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-echo-newmode.sh | sh -x /dev/stdin 2560 1440

# VNC WINDOW MAXIMIZED
## 2560x1348 59.95 Hz (CVT) hsync: 83.81 kHz; pclk: 291.00 MHz
# Modeline "2560x1348_60.00"  291.00  2560 2744 3016 3472  1348 1351 1361 1398 -hsync +vsync
curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-echo-newmode.sh | sh -x /dev/stdin 2560 1348

# VNC WINDOW MAXIMIZED
# 1712x900 59.92 Hz (CVT) hsync: 55.96 kHz; pclk: 126.25 MHz
# Modeline "1712x900_60.00"  126.25  1712 1808 1984 2256  900 903 913 934 -hsync +vsync
curl -jkL https://raw.githubusercontent.com/saaadel/scripts/master/linux/xrandr-set-newmode.sh | sh -x /dev/stdin 1706 900
