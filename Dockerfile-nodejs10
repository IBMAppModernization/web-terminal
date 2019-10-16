FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  cmake \
  curl \
  g++ \
  pkg-config \
  git \
  vim-common \
  libwebsockets-dev \
  libjson-c-dev \
  libssl-dev \
  sudo \
  systemd \
&& rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs
RUN curl -sL https://ibm.biz/idt-installer | bash
RUN git clone https://github.com/tsl0922/ttyd.git
RUN cd ttyd && mkdir build && cd build && cmake .. && make && make install
RUN npm install -g loopback-cli
EXPOSE 7681

CMD ["ttyd", "-p", "7681", "bash"]
