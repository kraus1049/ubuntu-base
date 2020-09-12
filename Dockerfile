FROM ubuntu:19.10
LABEL maintainer "kraus1049 <kraus1049@gmail.com>"

ENV DEFAULT_USER jovyan
ENV DEFAULT_GROUP developer
ENV DEFAULT_PASSWD passwd
ENV SHELL /bin/bash
ENV DEBIAN_FRONTEND "noninteractive"

RUN groupadd ${DEFAULT_GROUP} && \
    useradd -g ${DEFAULT_GROUP} -m ${DEFAULT_USER}

RUN apt-get update &&  \
    apt-get install -qy --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    fontconfig \
    fonts-ipaexfont \
    fonts-ipafont \
    fonts-ricty-diminished \
    fonts-roboto \
    fonts-takao \
    git \
    gnupg \
    gosu \
    libssl-dev \
    locales \
    pkg-config \
    software-properties-common \
    ssh \
    wget \
    sudo && \
    locale-gen ja_JP.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache -fv

RUN echo 'Defaults visiblepw' >> /etc/sudoers && \
    echo %$DEFAULT_GROUP' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo $DEFAULT_USER:$DEFAULT_PASSWD | chpasswd

USER $DEFAULT_USER
ENV HOME /home/${DEFAULT_USER}
ENV WORKDIR $HOME/work

# 一般ユーザがユーザ/グループを追加できるようにする
# entrypoint.sh内でパーミッションを元に戻す
RUN sudo chmod u+s /usr/sbin/usermod && \
    sudo chmod u+s /usr/sbin/groupmod && \
    sudo chmod u+s /usr/sbin/useradd

RUN sudo mkdir -p WORKDIR
WORKDIR ${WORKDIR}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN sudo chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["bash"]