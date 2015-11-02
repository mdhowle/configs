#!/bin/bash 
# Creates and updates an ArchLinux repository
#  - Find your mirror here: https://wiki.archlinux.org/index.php/Mirrors
#  - Be considerate, don't sync more than you need to (i.e. once a day)
#  - If you want 32-bit packages as well, remove "-x '.*i686.*'" 
#  - If you want more repositories, copy a mirror line and edit accordingly

MIRROR=ftp://_ARCHLINUX.MIRROR_
MIRROR_PATH=/pub/archlinux
LASTUPDATE_URL=_ARCHLINUX.MIRROR_/lastupdate
TARGET=/var/storage/repos/arch

curl -s "$LASTUPDATE_URL" > /tmp/lastupdate
if [ ! diff -b /tmp/lastupdate "$TARGET/lastupdate" > /dev/null 2>&1 ]; then
    exit 0
fi

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TARGET}/pool" ] && mkdir -p "${TARGET}/pool"


lftp $MIRROR  << EOF
lcd $TARGET
open 
# Use 'cd' to change into the proper directory on the mirror, if necessary.
cd $MIRROR_PATH
set xfer:clobber on
get -e lastupdate
set xfer:clobber
mirror -cve -x '.*i686.*' core &
mirror -cve -x '.*i686.*' extra &
mirror -cve -x '.*i686.*' community &
mirror -cve -x '.*i686.*' multilib &
lcd pool
cd pool
mirror -cve -x '.*i686.*' community &
mirror -cve -x '.*i686.*' packages &
bye
EOF
