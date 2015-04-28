# photo-booth
Bash script that takes photos, turns them into a gif with a caption.

## Installation
Requires ImageMagick

```
brew install imagemagick
brew install jp2a
```

Requires a camera on the computer to work.

## Usage

Run the shell script _gifme_.

```
./gifme.sh -w 'Your text here.'
```

## Use with caution!

Currently uses a ```rm``` command that isn't very secure.  Someone could make this an alias and run it from the wrong directory. Make the clean up process safer.  Only run this script from this directory.