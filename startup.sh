#!/bin/bash
x11vnc -storepasswd "${VNC_PASSWORD}" ~/.vnc/passwd
echo "exec start-firefox.sh" > ~/.xinitrc && chmod +x ~/.xinitrc
x11vnc -forever -usepw -create