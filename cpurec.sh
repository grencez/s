#!/bin/sh

# This script adds up the CPU usage of the
# given PIDs and their children (recursively).

arg=$1
verbose=''

case "$arg" in
  '-h'|'-help'|'--help'|'')
    echo "Usage: $0 [-v] [PID...]"
    exit 1
    ;;
  '-v')
    shift
    verbose=1
    ;;
esac

pidlist=`echo "$@" | sed -e 's/  */,/g'`

next_pids=$pidlist

PS='ps --no-headers'

while [ "$next_pids" ]
do
  next_pids=`$PS --ppid "$next_pids" -o pid | tr '\n' ',' | sed -e 's/,$//' -e 's/  *//g'`
  if [ "$next_pids" ]
  then
    pidlist="$pidlist,$next_pids"
  fi
done

if [ "$verbose" ]
then
  echo "$pidlist"
  $PS --pid "$pidlist" -o pcpu,pid,user,args
fi

sum=`$PS --pid "$pidlist" -o pcpu | tr '\n' ' ' | sed -e 's/^  *//' -e 's/  *$//' -e 's/  */ + /g'`

if [ "$verbose" ] ; then echo "$sum" ; fi

echo "$sum" | bc

