#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)
PASSWD=${PASSWD:-${DEFAULT_PASSWD}}
USER=${USER:-${DEFAULT_USER}}
GROUP=${GROUP:-${DEFAULT_GROUP}}
DEFAULT_HOME=${HOME}

# グループを作成する
echo "GROUP_ID: $GROUP_ID"
if [ x"$GROUP_ID" != x"0" ]; then
    groupmod -n $DEFAULT_GROUP $GROUP
    groupmod -g $GROUP_ID $GROUP
fi

# ユーザを作成する
echo "USER_ID: $USER_ID"
if [ x"$USER_ID" != x"0" ]; then
    export HOME=/home/$USER
    if [ x"$DEFAULT_USER" != x"$USER" ]; then
        useradd -N -m $USER
    fi
    usermod -o -d ${HOME} -m -u $USER_ID -g $GROUP $USER
    if [ x"$DEFAULT_USER" != x"$USER" ]; then
        ln -sL $DEFAULT_HOME/* $HOME
    fi
    cd $WORKDIR
fi

sudo chown $USER_ID:$GROUP_ID $WORKDIR

# パーミッションを元に戻す
sudo chmod u-s /usr/sbin/useradd
sudo chmod u-s /usr/sbin/usermod
sudo chmod u-s /usr/sbin/groupmod

exec $@