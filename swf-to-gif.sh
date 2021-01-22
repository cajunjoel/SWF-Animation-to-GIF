#!/usr/bin/env bash

# SWF Animation to Animated GIF
# Version 1.0
#
# Witten by Joel Richard (github.com/cajunjoel)
# Last Updated: 22 Jan 2021
#
# This code is in the public domain.
# Please see the LICENSE file for details.

if [ -z $1 ]; then
	/bin/echo "Usage: ./process.sh PATH_TO_FILE"
	exit 1
fi

FILENAME=`basename $1`
PATH=`dirname $1`

EXT="${FILENAME##*.}"
FILEBASE="${FILENAME%.*}"

if [ "$EXT" != "swf" ]; then
	/bin/echo "Please suppply a SWF file."
	exit 1;
fi

SRC="$1"
DST="GIFs/$FILEBASE"
FDST="GIFs/$FILEBASE.gif"

echo -n "Calculating number of animation frames..."
FRAMES=$(./ruffle_desktop --timedemo $1 2> /dev/null | /usr/bin/fgrep Ran | /usr/bin/cut -f 2 -d ' ')
echo $FRAMES

/bin/mkdir -p "$DST"
/bin/echo "Extracting PNG files..."
./exporter "$SRC" "$DST" --frames $FRAMES

# add leading zeros
/bin/echo "Renaming extracted PNGs..."
pushd "$DST"
for a in [0-9]*.png; do
  /bin/mv $a `printf %04d.%s ${a%.*} ${a##*.}`
done
popd

/bin/echo "Converting PNGs to GIF..."
/usr/local/bin/mogrify +dither -format gif $DST/*.png 

/bin/echo "Creating Animated GIF..."
/usr/local/bin/gifsicle -d 10 -O3 -k256 --no-loopcount $DST/*.gif > "$FDST"

/bin/echo "Moving to htdocs..."
/bin/cp "$FDST" "$PATH"

/bin/echo "Cleaning up..."
/bin/rm -r "$DST"
