#!/bin/bash


if [ -z "$STREAM_KEY" ]; then
  echo
  echo "必须设置STREAM_KEY环境变量."
  echo
  exit
fi

# aplay -l找到ALSA设备

#variable definitions
INRES="1920x1080" # 输入分辨率
OUTRES="1920x1080" # 输出分辨率
#OUTRES="1440x810" # o输出分辨率
FPS="15" # 目标FPS
GOP="30" # i-frame间隔，应该是FPS的两倍
GOPMIN="15" # 最小i帧间隔，应该等于fps，
THREADS="2" #最多6
CBR="1300k" # 恒定比特率（应该在1000k  -  3000k之间）
QUALITY="veryfast" # one of the many FFMPEG preset
AUDIO_RATE="44100"
#to hide logs use= -loglevel quiet
ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -i hw:3,0 -f flv -ac 2 -ar $AUDIO_RATE \
  -vcodec libx264 -keyint_min 3 -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p \
  -s $OUTRES -preset $QUALITY -acodec mp3 -threads $THREADS \
  -bufsize $CBR "rtmp://usmedia3.livecoding.tv:1935/livecodingtv/$STREAM_KEY"
