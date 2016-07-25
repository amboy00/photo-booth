# photo-booth
Bash script that takes photos, turns them into a gif with a caption.

## Installation
Requires ImageMagick and other packages installed via homebrew

```
brew install imagesnap
brew install imagemagick
brew install jp2a
```

### Twitter

To use twitter from the command line, install the `t` gem.  And follow its setup instructions.  If your target Twitter account already has your "app" created and authorized, then you just need to reauthorize for your computer.

```
gem install t
```

### link

Make a link to the shell script if you want to avoid having to type `./gifme.sh` every time.

```
$ ln -s ~/location-top/photo-booth/gifme.sh ~/bin/photobooth
```

> Note: the command `photobooth` will work, but you still need to run it from within the "photo-booth" directory to read the ASCII font. Sorry.

Requires a camera on the computer to work.

## Usage

Run the shell script _gifme_.

```
./gifme.sh -w 'Your text here.'
```

## Use with caution!

Currently uses a ```rm``` command that isn't very secure.  Someone could make this an alias and run it from the wrong directory. Make the clean up process safer.  Only run this script from this directory.

## Optional

In the script, we have a command that posts to Twitter using [t](https://github.com/sferik/t).  It takes some set up, but it's fun too.