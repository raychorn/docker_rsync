#!/bin/bash

DIR0="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

apt-get install cifs-utils -y

mkdir -p ${DEST_DIR}
mount -t cifs -o "username=${username},password=${password}" ${DEST_SMB} ${DEST_DIR}

docker run --rm \
    --name=rsync \
    --env TZ="${TZ}" \
    --env RSYNC_CRONTAB="crontab" \
    --volume ~/rsync:/rsync
    --volume ${SOURCE_DIR}:/data/src \
    --volume ${DEST_DIR}:/data/dst \
    ogivuk/rsync