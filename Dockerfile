###
#
# Thanks to @philstenning for providing an example that we could use as a starting point:
#
# https://github.com/philstenning/Firefox-in-docker-with-VNC/blob/master/DockerFile
#
###

FROM ubuntu

ENV BROWSER_URL="https://jupyter.xlscsde.local"
ENV VNC_PASSWORD="1234"

# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN apt-get update && apt-get install -y x11vnc xvfb wget
RUN install -d -m 0755 /etc/apt/keyrings
RUN wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
RUN gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
RUN echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
RUN echo "Package: *" > /etc/apt/preferences.d/mozilla
RUN echo "Pin: origin packages.mozilla.org" >> /etc/apt/preferences.d/mozilla 
RUN echo "Pin-Priority: 1000" >> /etc/apt/preferences.d/mozilla
RUN apt-get update
RUN apt-get install -y firefox

RUN mkdir ~/.vnc
# Setup a password
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

COPY --chmod=0777 ./startup.sh /root/startup.sh
COPY --chmod=0777 ./start-firefox.sh /usr/bin/start-firefox.sh
COPY ./override.ini /root/override.ini


EXPOSE 5900
CMD    ["/root/startup.sh"]