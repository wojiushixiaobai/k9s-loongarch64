FROM golang:1.19-loongnix

ARG K9S_VERSION=v0.26.7

ENV K9S_VERSION=${K9S_VERSION}

RUN set -ex; \
    git clone -b ${K9S_VERSION} https://github.com/derailed/k9s /opt/k9s

WORKDIR /opt/k9s

ENV GOPROXY=https://goproxy.io \
    CGO_ENABLED=0

RUN set -ex; \
    sed -i 's@h1:9AyPjBR0yr8t4e+pQMayLhc9AASediouUGpcoDvwy+Q=@h1:Fn3n8yNfQX/rJyWXuyfc2C55St2wAipVb285R0alN6g=@g' go.sum; \
    make build

RUN set -ex; \
    mkdir /opt/k9s/dist; \
    cd execs; \
    cp ../LICENSE ./; \
    cp ../README.md ./; \
    tar czf /opt/k9s/dist/k9s_$(uname -s)_$(uname -m).tar.gz .; \
    cd /opt/k9s/dist; \
    sha256sum k9s_$(uname -s)_$(uname -m).tar.gz | tee checksums.txt;

VOLUME /dist

CMD cp -rf dist/* /dist/
