#!/bin/sh

export DISPLAY=:99

while true
do
  {
    sudo /etc/init.d/xvfb start && sleep 3
    /etc/init.d/x11vnc start
    sudo /etc/init.d/ssh start
  } > /dev/null 2>&1

  startxfce4
sleep 5
done
