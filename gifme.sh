#!/bin/bash
#
#

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

clear
# figlet "Welcome to CLI Booth!"

toilet -f 'SlantRelief.flf' 'CLI Booth' -w 200

printf "\n\n\nCLI Booth is a Command Line Interface (CLI) that takes five photos and tweets the captured images as a gif.\n"
printf "Tell who you are and @clibooth will AT you this pic!\n\n"
printf "${RED}Please enter your twitter handle: ${NORMAL}@"
read TWITTER_INPUT
printf "\n${RED}Enter a caption: ${NORMAL}"
read CAPTION_INPUT


# Sanitize input, assign to new variable but limit it to 10 characters
export TWITTER="`echo "${TWITTER_INPUT//[^a-zA-Z0-9 ]/}" | cut -c -15`"
export CAPTION="`echo "${CAPTION_INPUT//[^a-zA-Z0-9 ]/}" | cut -c -80`"


clear
toilet -f 'SlantRelief.flf' 'Get ready!' -w 200

# get width of terminal
WIDTH=200

# Take a bunch of photos
for (( i=0 ; i < 5 ; i++ ))
do
  imagesnap -w 2 snapshot-$i.jpg
  convert snapshot-$i.jpg snapshot-$i.png
  clear
  # jp2a --colors snapshot-$i.png --clear
  picture-tube snapshot-$i.png --cols $WIDTH

  composite -compose atop -gravity south watermark.png snapshot-$i.png snapshot-$i.png
  echo "You are doing great!"

done
# Make a gif
convert -dispose none -delay 50 snapshot-*.png -scale 1024x768 -size 1024x768 source.gif

shift $(($OPTIND - 1))

clear

if [ "$CAPTION" ]
then
  printf "Saving File with '$CAPTION'...\n"
  convert source.gif -size 1024x768 -font /Library/Fonts/Futura.ttc -pointsize 36 -fill black -draw "text 40,50 '$CAPTION' fill white text 38,48 '$CAPTION' fill white" -loop 0 -layers Optimize -quantize RGB +dither -colors 64 output.gif
else
  printf "Saving File...\n"
  CAPTION="Another great tweet"
  convert source.gif -size 1024x768 -loop 0 -layers Optimize -quantize RGB +dither -colors 64 output.gif
fi

if [ -z "$TWITTER" ]
then
  TWITTER="clibooth"
fi


# remove image files
find *.jpg | xargs rm
rm snapshot-0.png
rm snapshot-1.png
rm snapshot-2.png
rm snapshot-3.png
rm snapshot-4.png

sleep 1
printf "Tweeting to ${CYAN}@clibooth${NORMAL}...\n"
sleep 1

# open .

$(t update "$CAPTION by @$TWITTER" -f output.gif)
echo "Ignore these warnings. Everything is fine. Just fine."
toilet -f 'SlantRelief.flf' 'All done!' -w 200 --gay
printf "\n\nGo to URL ${CYAN}http://twitter.com/clibooth${NORMAL} to see your tweet!"
