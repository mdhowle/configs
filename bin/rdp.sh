#!/bin/bash
# Wrapper to rdesktop/rdesktop-vrdp
#
# rdp.sh ServerName/IPAddress

USERNAME=`whoami`
DOMAIN=YOURDOMAIN
RESOLUTION="1600x1050"

# For VirtualBox, the included "rdesktop-vrdp" seems to work best
# Add the VirtualBox guest servernames
VRDP_SERVERS=("")

if [ -z $1 ]; then
	echo "Pass a servername"
	exit 1
fi

rdesktop=$(which rdesktop)

sound="-r sound:local"
for server in "$VRDP_SERVERS"; do
  if [[ $1 == *$server* ]]; then   
    rdesktop=$(which rdesktop-vrdp)
#    sound="-r sound:local:oss"
    break
  fi
done

exec $rdesktop -N  -u $USERNAME -d $DOMAIN -g $RESOLUTION -T $1 -a 16 -b -5 -x:l -r clipboard:PRIMARYCLIPBOARD $sound -r disk:home=$HOME "$@" &> /dev/null &
