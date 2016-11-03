# docker-vim-bootstrap

### Installation

Edit `vimrc.local` and/or `vimrc.local.bundles` and then build.

```sh
$ git clone https://github.com/sfrique/docker-vim-bootstrap.git
$ cd docker-vim-bootstrap
$ [Edit vimrc.local and/or vimrc.local.bundles]
$ sudo docker build -t vim-bootstrap .
```

### Usage

For now:

```sh
$ cd ${YOUR_SOURCE_CODE}
$ sudo docker run --rm -tiv `pwd`:/projects vim-bootstrap [${FILE}]
```

For basic vim-bootstrap usage: [vim-bootstrap](https://github.com/avelino/vim-bootstrap)

### TODO

- Add tmux
