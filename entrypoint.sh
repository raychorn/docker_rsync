#!/bin/bash

DIR0="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

apt-get install cifs-utils -y

# install docker command line tools
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install docker-ce -y

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