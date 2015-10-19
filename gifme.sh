#!/bin/sh
#
#
clear
echo "Warming up the camera!\n"

# Take a bunch of photos
for (( i=0 ; i < 5 ; i++ ))
do
  imagesnap -w 2 snapshot-$i.jpg
  clear
  jp2a --colors  snapshot-$i.jpg

  composite -compose atop -gravity southeast FP-Logo.png snapshot-$i.jpg snapshot-$i.jpg

done
# Make a gif
convert -dispose none -delay 50 *.jpg -scale 1024x768 -size 1024x768 source.gif

wflag=
while getopts 'w:' OPTION
do
  case $OPTION in
    w)  wflag="$OPTARG"
        ;;
    ?)  printf "Usage: %s: [-w value]\n" $(basename $0) >&2
        exit 2
        ;;
  esac
done
wflag+=' #FrontPorchIO'

shift $(($OPTIND - 1))

clear

if [ "$wflag" ]
then
  printf "Saving File with - $wflag\n"
  convert source.gif -size 1024x768 -font /Library/Fonts/Futura.ttc -pointsize 36 -fill black -draw "text 40,34 '$wflag' fill white text 41,33 '$wflag' fill white" -loop 0 -layers Optimize -quantize RGB +dither -colors 64 output.gif
fi

# remove image files
find *.jpg | xargs rm

echo "output.gif created. Showing in Finder."
sleep 1
echo "sending to twitter's @FrontPorchIO"
sleep 1

# open .

$(t update 'Live from the photo bash #frontporchio' -f output.gif)
# photo bash.  Get it?  Bash!!!