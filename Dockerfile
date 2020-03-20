FROM ubuntu:19.10
LABEL maintainer "kraus1049 <kraus1049@gmail.com>"

ENV USER jovyan
ENV HOME /home/${USER}
ENV WORKDIR $HOME/work
ENV SHELL /bin/bash

RUN apt-get update &&  \
apt-get install -y  curl git gosu locales && \
locale-gen ja_JP.UTF-8 && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* &&  \
mkdir $HOME && \
echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc  && \
mkdir -p $WORKDIR

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
WORKDIR $WORKDIR
CMD ["bash"]