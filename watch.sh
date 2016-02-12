#!/usr/bin/env bash
# script:  watch
# author:  Mike Smullin <mike@smullindesign.com>
# license: GPLv3
# description:
#   watches the given path for changes
#   and executes a given command when changes occur
# usage:
#   watch <path> <cmd...>
#

# Edited by Michael Giancola (GitHub: ikeandmike) on February 11, 2015
# Modifications
# (1) Swapped rebuild and quit commands (personal preference)
# (2) Watch quits once path has rebuilt once (this is used in conjunction with
#     swatch.sh, which allows the user to monitor an entire directory for changes)
# (3) Changed echo'd messages a bit (to be more fitting to swatch)
# (4) Impossible to force rebuild because watch runs in the background, however
#     I felt this feature wasn't super useful anyway

path=$1
shift
cmd=$*
sha=0
update_sha() {
  sha=`ls -lR --time-style=full-iso $path | sha1sum`
}
update_sha
previous_sha=$sha
build() {
  echo -e " building...\n"
  $cmd
  exit
}
compare() {
  update_sha
  if [[ $sha != $previous_sha ]] ; then
    echo -en "\nchange detected,"
    build
    previous_sha=$sha
  else
    echo -n .
  fi
}
trap exit SIGINT # Indicate to swatch that user wants to quit

echo -e  "\n--> Press Ctrl+C to exit."
if [ $path == "." ] ; then
  echo -en "--> watching working directory for changes"
else
  echo -en "--> watching \"$path\" for changes"
fi
while true; do
  compare
  sleep 1
done
