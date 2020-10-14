FROM ubuntu:16.04

ARG MACHINE_VERSION
ARG GO_VERSION
ENV GOPATH /go

RUN apt-get update && apt-get install -y libvirt-dev curl git gcc
RUN curl -sSL https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xzf -
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/go/bin
