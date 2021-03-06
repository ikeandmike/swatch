# swatch
Bash script which rebuilds when it detects changes in the working directory.

## Author
Michael Giancola

## Description
Wrapper for ```watch.sh```. Watch monitors a single file for changes, running a command when it detects changes. Swatch monitors the entire file directory, and runs recompile.sh (user-defined script) when changes are detected. In addition, you can run prog.sh (also user-defined) at any time by pressing Ctrl+\. 

For my personal use, recompile.sh contains commands to recompile a C program, and prog.sh contains commands to run a C program.

## Usage
./swatch.sh

## Inspiration:
I created this project while I should've been studying for midterms because I was toying around with ```watch.sh``` and wanted to add functionality. Watch is a script created by Mike Smullin (see GitHub Gist repo [here](https://gist.github.com/mikesmullin/6401258)) to rebuild a file after it is modified. The script itself is incredibly useful, however it only works for a single file. I created a wrapper that allows watch to be used to detect changes in any file in the working directory.

Simply write the rebuild commands you want in ```recompile.sh```, then run ```swatch.sh```. I personally found this script useful for recompiling C programs, but it could be used in other applications.

## License:
watch.sh has a GPLv3 license, so I will use the same license for all the modifications and new files I created. watch.sh was created by Mike Smullin, however the version in this repo has slight modifications.
