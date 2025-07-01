FROM nvcr.io/nvidia/cuda:12.4.1-devel-ubuntu22.04
# Prevent stop building ubuntu at time zone selection.  
ENV DEBIAN_FRONTEND=noninteractive

# 换apt源
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bk
COPY sources.list /etc/apt/sources.list

# 换pip源
RUN mkdir /root/.pip
COPY pip.conf /root/.pip/pip.conf

RUN apt-get update
RUN apt update && apt install -y wget git python3-pip libglib2.0-0 libgl1 git-lfs

RUN apt-get install -y openssh-server  
RUN apt-get install -y xfce4 xfce4-terminal 
RUN apt-get install -y xfce4-goodies x11vnc
RUN apt-get install -y sudo bash xvfb
RUN useradd -ms /bin/bash ubuntu
RUN echo 'ubuntu:123456' | chpasswd
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN rm -rf /var/lib/apt/lists/*

COPY x11vnc /etc/init.d/
COPY xvfb /etc/init.d/
COPY entry.sh /

RUN sudo chmod +x /entry.sh /etc/init.d/* 

RUN apt-get update

EXPOSE 5900

ENTRYPOINT [ "/entry.sh" ]

# docker build -t 3dgs .
# docker run -itd --runtime=nvidia --gpus all --name=3DGS --privileged --shm-size=8gb -v E:/UbuntuShared/3DGS/:/root/3DGS/ -p 5900:5900 -e PASSWORD=password 3dgs 
