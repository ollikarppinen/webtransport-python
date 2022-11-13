Installing `aioquic` with `openssl@1.1` + M1 mac:
```
$  brew install openssl
$  export CFLAGS=-I/opt/homebrew/opt/openssl@1.1/include
$  export LDFLAGS=-L/opt/homebrew/opt/openssl@1.1/lib
$  pipenv install aioquic
```

```
/opt/homebrew/opt/openssl@1.1/bin/openssl req -newkey rsa:2048 -nodes -keyout certificate.key -x509 -out certificate.pem -subj '/CN=Test Certificate' -addext "subjectAltName = DNS:localhost"
/opt/homebrew/opt/openssl@1.1/bin/openssl x509 -pubkey -noout -in certificate.pem | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | base64
/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --no-sandbox --origin-to-force-quic-on=localhost:4433 --ignore-certificate-errors-spki-list=0dMmHcDopZsE8k0buRD/gKcqNcoccvOwe5iqWmoDCtc= file:///Users/ollikarppinen/dev/webtransport-python/client.html

pipenv run python server.py
```
