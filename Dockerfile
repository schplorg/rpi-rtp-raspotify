FROM ubuntu
MAINTAINER Sam Bäumer <sam@schplorg.de>
RUN apt-get update && apt-get install -y pulseaudio alsa-utils nano less wget
RUN wget https://dtcooper.github.io/raspotify/raspotify-latest.deb
RUN dpkg -i raspotify-latest.deb
COPY default.pa /etc/pulse/default.pa
#COPY raspotify /etc/default/raspotify
ENV DEVICE_NAME="raspotify"
ENV BITRATE="160"
ENV CACHE_ARGS="--disable-audio-cache"
ENV VOLUME_ARGS="--enable-volume-normalisation --linear-volume --initial-volume=100"
ENV BACKEND_ARGS="--backend alsa"
CMD pulseaudio --start && \
/usr/bin/librespot \
--name ${DEVICE_NAME} \
$BACKEND_ARGS \
--bitrate ${BITRATE} \
$CACHE_ARGS \
$VOLUME_ARGS \
$OPTIONS \
&& /bin/bash