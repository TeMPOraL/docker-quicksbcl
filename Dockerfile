FROM ubuntu:trusty
MAINTAINER Jacek Złydach <jz@s-arts.pl>

# Based on https://github.com/davazp/docker-sbcl & https://github.com/davazp/docker-quicksbcl

## Set up server
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y make wget bzip2

## Download & install SBCL

RUN wget http://prdownloads.sourceforge.net/sbcl/sbcl-1.2.6-x86-64-linux-binary.tar.bz2 -O /tmp/sbcl.tar.bz2 && \
    mkdir /tmp/sbcl && \
    tar jxvf /tmp/sbcl.tar.bz2 --strip-components=1 -C /tmp/sbcl/ && \
    cd /tmp/sbcl && \
    sh install.sh && \
    cd /tmp \
    rm -rf /tmp/sbcl/

## Download & install quicklisp

ENV HOME /root

WORKDIR /tmp/
RUN wget http://beta.quicklisp.org/quicklisp.lisp
ADD install.lisp /tmp/install.lisp

RUN sbcl --non-interactive --load install.lisp

WORKDIR /root
