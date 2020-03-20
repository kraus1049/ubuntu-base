#!/bin/bash

USER_ID=${UID:-9001}
GROUP_ID=${GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -M $USER
groupmod -g $GROUP_ID $USER

exec /usr/sbin/gosu $USER "$@"