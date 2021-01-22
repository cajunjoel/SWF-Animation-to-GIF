# SWF-Animation-to-GIF
This script, which relies on the Ruffle and ImageMagick projects, is meant to convert a plain SWF animation to an animated GIF.

## Notes
This runs on Linux/OS X. If you're on Windows, this script can be converted to a powershell script. That is left as an excercise to the reader.

## Install Ruffle
This relies on the `ruffle_desktop` and `exporter` commands from the https://github.com/ruffle-rs/ruffle project. Install it first per their instructions. I had to compile it from scratch since the packages don't seem to offer more than the desktop command.

## Install ImageMagick
This uses the `mogrify` command from ImageMagick at https://imagemagick.org. Install per their instructions.

## Usage
`./swf-to-gif.sh FILENAME`

FILENAME is the full path to the SWF file you want to convert. When the script is complete an animated GIF will be placed in the same directory as the SWF file. A copy of the animated GIF will also be placed in a `./GIFs` directory.
