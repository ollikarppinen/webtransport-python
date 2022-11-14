Based on https://github.com/GoogleChrome/samples/tree/gh-pages/webtransport

# Getting started

## setup certs (macbook m1)

```bash
/opt/homebrew/opt/openssl@1.1/bin/openssl req -newkey rsa:2048 -nodes -keyout certificate.key -x509 -out certificate.pem -subj '/CN=Test Certificate' -addext "subjectAltName = DNS:localhost"
/opt/homebrew/opt/openssl@1.1/bin/openssl x509 -pubkey -noout -in certificate.pem | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | base64
# 0dMmHcDopZsE8k0buRD/gKcqNcoccvOwe5iqWmoDCtc=
# The output of the last command for starting up chrome
```

## install python dependencies

https://www.google.com/search?q=pyenv&oq=pyenv&aqs=chrome.0.69i59l4j0i512l3j69i60.668j0j7&sourceid=chrome&ie=UTF-8

Installing `aioquic` with `openssl@1.1` + M1 mac:
```bash
# $  brew install openssl
$  export CFLAGS=-I/opt/homebrew/opt/openssl@1.1/include
$  export LDFLAGS=-L/opt/homebrew/opt/openssl@1.1/lib
$  pipenv install
```

## run servers

```bash
pipenv run python server.py certificate.pem certificate.key
npm run start
```

## start chrome

https://github.com/kixelated/warp-demo#chrome

```
# replace the ignore-certificate-errors-spki-list value
/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --no-sandbox --origin-to-force-quic-on=localhost:4433 --ignore-certificate-errors-spki-list=0dMmHcDopZsE8k0buRD/gKcqNcoccvOwe5iqWmoDCtc= http://localhost:3000/client.html
```

## Start the HSL chunker

```
# requires ffmpeg
# get a sample video, for example:
wget http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4 -O media/source.mp4

(cd media && INPUT_FILE_PATH=./source.mp4 . ../chunk.sh)

# optionally test out the stream with vlc
/Applications/VLC.app/Contents/MacOS/VLC http://localhost:3000/media/stream.m3u8
```
