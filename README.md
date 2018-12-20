# wormhole-docker
This repository contains a Dockerfile and bash shell scripts for building
a Wormhole full node on the Bitcoin Cash (BCH) network. By default, this node
is setup for **testnet**. This repo was forked from
[wormhole-docker](https://github.com/christroutner/wormhole-docker). That repo
builds the Wormhole full node from source, whereas this repo creates the full
node from an officially release binary.


## Installation
These directions are geared at Ubuntu 18.04 OS with at least 2GB of RAM,
and a non-root user with sudo privileges.
The testnet blockchain data takes up about 20GB of space.
Your mileage may vary.

1. It's always a good idea to add
[swap space](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-16-04)
to a new system. I recommend 8GB of swap typically.

2. Install Docker on the host system. Steps 1 and 2 in
[this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
shows how to install Docker on a Ubuntu system.

3. Clone this repository:

`git clone https://github.com/christroutner/docker-wormhole-bin && cd docker-wormhole-bin`

* Create a `wh-blockchain-data` directory in your home directory:

`mkdir ~/wh-blockchain-data`

* Build the Docker images by running the 'build' shell script:

`./build-image`

* After the Docker image has been build, you can start it with the 'run' shell script:

`./run-image`

* You can check on progress with the command `docker logs wormhole-node`.
