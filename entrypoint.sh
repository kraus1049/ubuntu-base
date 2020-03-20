#!/bin/bash

USER_ID=${UID:-9001}
GROUP_ID=${GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -M $USER
groupmod -g $GROUP_ID $USER
chown -R $USER_ID:$GROUP_ID $HOME

exec /usr/sbin/gosu $USER "$@"