#!/bin/sh

outf=

if [ "$1" = '-o' ]
then
  outf=$2
  shift 2
fi

if [ "$1" == '--' ]
then
  shift 1
fi

if [ "$outf" ]
then
  { time "$@" ; } 2>&1 | tee "$outf"
else
  { time "$@" ; } 2>&1
fi

