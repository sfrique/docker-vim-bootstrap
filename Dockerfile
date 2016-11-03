FROM alpine:3.4

MAINTAINER Henrique Santos Fernandes <sf.rique@gmail.com>

ENV HOME /home/developer
ENV EDITOR vim
# LANGS c,elixir,erlang,go,haskell,html,javascript,lisp,lua,ocaml,perl,php,python,ruby
ENV VIM_BOOTSTRAP_LANGS erlang,go,html,javascript,lua,perl,php,python,ruby
# ENV VIM_BOOTSTRAP_CURL_LANGS langs=erlang&langs=go&langs=html&langs=javascript&langs=lua&langs=perl&langs=php&langs=python&langs=ruby
ENV DOCKER_VIM_BOOTSTRAP_SHA 197c482f05a29d386885a28995f6fc0d61c8b4db
ENV GOPATH /go

RUN mkdir ${HOME}

RUN apk add --no-cache \
	ctags \
	curl \
	git \
	go \
	grep \
	libstdc++ \
	py-pip \
	python3 \
	vim \
    ncurses

COPY vimrc.local ${HOME}/.vimrc.local
COPY vimrc.local.bundles ${HOME}/.vimrc.local.bundles

RUN apk add --no-cache --virtual build-deps \
	abuild \
	bash \
	binutils \
	build-base \
	cmake \
	gcc \
	llvm \
	musl-dev \
	perl \
	python-dev \
	python3-dev && \
	ln -s /usr/bin/make /usr/bin/gmake && \
	go get github.com/avelino/vim-bootstrap && \
	cd $GOPATH/src/github.com/avelino/vim-bootstrap && \
	git submodule init && \
	git submodule update && \
	git checkout ${DOCKER_VIM_BOOTSTRAP_SHA} && \
	go build && \
	./vim-bootstrap -langs=${VIM_BOOTSTRAP_LANGS} -editor=${EDITOR} > ${HOME}/.vimrc && \
    # curl 'http://vim-bootstrap.com/generate.vim' --data '${VIM_BOOTSTRAP_CURL_LANGS}&editor=${EDITOR}' > ${HOME}/.vimrc && \
	vim -E -s -c "source ~/.vimrc" -c "+PluginInstall +qall" || \
	apk del build-deps

WORKDIR /projects/

ENTRYPOINT ["vim"]
