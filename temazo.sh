#!/bin/bash 
#        https://www.youtube.com/results?search_query=thunderstruck+seagulls

quebusco=$(echo $*  | tr " " "+" )
urlachupar=$(curl -s "https://www.youtube.com/results?search_query=$quebusco"| grep -m1 "/watch" | sed "sx.*href=\"/watchxhttps://www.youtube.com/watchx" | cut -d \" -f1)
youtube-dl --version >> /music/versio_yt_dl
FILENAME="$(youtube-dl -x --audio-format mp3 --audio-quality 0 "$urlachupar"  | grep '[ffmpeg] Destination: ' | sed "s/^\[ffmpeg\] Destination: //" )"
#echo $FILENAME >> /music/file1.mp3
#echo $FILENAME
NEWFILENAME="$( echo $FILENAME | sed "s/-[^-]\+\.mp3/.mp3/" )"
#mv "$FILENAME" "$NEWFILENAME"
mv "$FILENAME" "/music/test.mp3"
