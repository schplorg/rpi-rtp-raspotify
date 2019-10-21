# rpi-rtp-raspotify
Stream Raspotify over RTP using PulseAudio.

Based on 
- [Raspotify](https://github.com/dtcooper/raspotify) by David Cooper
- Docker
- PulseAudio

# Build
`docker build -t username/raspotify ./`

# Run
`docker run -itd --privileged  --net=host username/raspotify`

# Notes
Sound hardware access needs docker parameter:
`--privileged`

PulseAudio needs docker parameter
`--net=host`

Run a container:

 `docker run -it --privileged --net=host ubuntu`

Play test sound:

`aplay /usr/share/sounds/alsa/Front_Center.wav`

Run PulseAudio:

`pulseaudio --start`

`pulseaudio --kill`

PulseAudio network config:
```
load-module module-position-event-sounds
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
load-module module-null-sink sink_name=rtp
load-module module-rtp-send source=rtp.monitor port=45678
set-default-sink rtp
```

Adding and using a User:
```
RUN useradd -c 'New user' -m -d /home/docky -s /bin/bash docky
RUN chown -R docky.docky /home/example.txt
USER docky
ENV HOME /home/docky
```

Listen to multicast RTP stream:

`rtp://224.0.0.56:45678`