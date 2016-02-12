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
# (3) Passes special exit code to swatch to indicate the user wants to quit
# (4) Doesn't print "." while waiting, caused weird issues with swatch on close
# (5) Changed echo'd messages a bit (to be more fitting to swatch)

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
    echo -n "change detected,"
    build
    previous_sha=$sha
  fi
}
trap exit SIGINT # Indicate to swatch that user wants to quit

echo -e  "\n--> Press Ctrl+C to exit."
if [ $path == "." ] ; then
  echo -e "--> watching working directory for changes"
else
  echo -e "--> watching \"$path\" for changes"
fi
while true; do
  compare
  sleep 1
done
