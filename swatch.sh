#!/bin/bash
# Script: swatch
# Author: Michael Giancola
# Description: Wrapper for watch.sh which runs recompile.sh when any file in the
#              working directory is modified
# Usage:
#        ./swatch

# Notes:
#(0) Quits successfully on CTRL+C
#    Runs program on CTRL-\
#(1) Tells watch to monitor entire directory, running recompile when
#    a file changes
#(2) Store PID of watch call
#(3) Wait for watch to finish
#(4) Pause until rebuild is (hopefully) finished, then start again

# Remark: swatch responds to CTRL+C because watch is run in background

handle_exit() {
  kill $PID     # Finish of watch background process
  echo          # Newline to start terminal on clean line
  exit
}

handle_run() {
  kill $PID       #Stop watch for now
  echo
  ./prog.sh &     #Run program
  PID2=$!
  wait $PID2      #Wait on program call
}

trap handle_exit SIGINT       # (0)
trap handle_run  SIGQUIT

while true; do
./watch.sh . ./recompile.sh & # (1)
PID=$!                        # (2)
wait $PID                     # (3)
sleep 1                       # (4)
done
