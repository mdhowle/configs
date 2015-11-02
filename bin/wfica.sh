#!/bin/sh
# Custom Citrix ICA Client script
# wfica.sh launch.ica

export ICAROOT=/opt/Citrix/ICAClient

dname=`dirname $1`
fname=`basename $1`

# Make a backup of the file
if [[ "$1" != launch* ]]; then
    cp "$1" "$dname/_$fname"
fi

${ICAROOT}/wfica -file "$1"

# Restore the file
if [ -a "_$1" ]; then
    mv "$dname/_$fname" "$1"
fi
