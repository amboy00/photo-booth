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
done
# Make a gif
convert -dispose none -delay 20 *.jpg -scale 500x281 -size 500x281 source.gif
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

shift $(($OPTIND - 1))

if [ "$wflag" ]
then
  printf "Saving File with $wflag\n"
  convert source.gif -size 500x281 -font /Library/Fonts/Futura.ttc -pointsize 24 -fill blue -draw "text 10,34 '$wflag' fill magenta text 8,32 '$wflag' fill purple" -loop 0 -layers Optimize output.gif
fi

# remove image files
find *.jpg | xargs rm
echo "output.gif created. Showing in Finder."
open .
