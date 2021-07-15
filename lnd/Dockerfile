FROM golang:1.16.3-alpine as builder


ENV GODEBUG netdns=cgo
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

ARG checkout="master"

# Install dependencies and build the binaries.
RUN apk add --no-cache --update alpine-sdk \
    git \
    make \
    gcc \
&&  git clone https://github.com/lightningnetwork/lnd /go/src/github.com/lightningnetwork/lnd \
&&  cd /go/src/github.com/lightningnetwork/lnd \
&&  git checkout $checkout \
&&  make release-install

FROM alpine as final

EXPOSE 9735 10009

COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/

RUN apk add --no-cache bash

VOLUME ["/root/.bitcoin"]
VOLUME ["/root/.lnd"]

CMD ["--debuglevel=debug", "--maxpendingchannels=10", "--rpclisten=0.0.0.0:10009", "--color=#4126a7", "--alias=MDMA", "--bitcoin.active", "--bitcoin.testnet", "--bitcoin.node=bitcoind", "--bitcoind.rpchost=btc", "--bitcoind.rpcuser=test", "--bitcoind.rpcpass=test", "--bitcoind.zmqpubrawblock=tcp://btc:28332", "--bitcoind.zmqpubrawtx=tcp://btc:28333", "--autopilot.active", "--autopilot.maxchannels=5", "--autopilot.allocation=0.6"]
ENTRYPOINT ["lnd"]
