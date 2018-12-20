# Creates a Wormhole full node based on the binary release by Bitmain

#IMAGE BUILD COMMANDS
FROM ubuntu:18.04
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

#Update the OS and install any OS packages needed.
RUN apt-get update
RUN apt-get install -y sudo git curl nano gnupg wget

#Install Node and NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs build-essential

#Create the user 'wormhole' and add them to the sudo group.
RUN useradd -ms /bin/bash wormhole
RUN adduser wormhole sudo

#Set password to 'password' change value below if you want a different password
RUN echo wormhole:password | chpasswd

#Set the working directory to be the connextcms home directory
WORKDIR /home/wormhole

#Setup NPM for non-root global install
RUN mkdir /home/wormhole/.npm-global
RUN chown -R wormhole .npm-global
RUN echo "export PATH=~/.npm-global/bin:$PATH" >> /home/wormhole/.profile
RUN runuser -l wormhole -c "npm config set prefix '~/.npm-global'"


RUN mkdir /home/wormhole/.bitcoin
# Testnet configuration file
COPY config/testnet-example/bitcoin.conf /home/wormhole/.bitcoin/bitcoin.conf
# Mainnet configuration file
#COPY config/mainnet-example/bitcoin.conf /home/wormhole/.bitcoin/bitcoin.conf

# Download the 0.2.2 wormhole full node binary for x86.
# Edit these as needed and as new software versions are release. Bin release repo:
# https://wormhole.cash/download/
RUN wget https://wormhole.cash/download/0.2.2/linux_wormhole/wormhole-0.2.2-x86_64-linux-gnu.tar.gz
RUN tar -xvf wormhole-0.2.2-x86_64-linux-gnu.tar.gz
RUN mv /home/wormhole/wormhole-0.2.2 /home/wormhole/wormhole

#Create a directory for holding blockchain data
VOLUME /home/wormhole/blockchain-data

# Expose the different ports

# Mainnet
#EXPOSE 8332
# Testnet
EXPOSE 18333

# ZeroMQ websockets
EXPOSE 28332

# Switch to user account.
USER wormhole
# Prep 'sudo' commands.
#RUN echo 'password' | sudo -S pwd


# Startup bitcore, wormhole, and the full node.
CMD ["/home/wormhole/wormhole/bin/wormholed"]
