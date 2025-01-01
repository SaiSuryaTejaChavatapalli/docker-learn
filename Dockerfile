# Take Base Image as Ubuntu
FROM ubuntu

# Install node.js in this image
RUN apt-get update
RUN apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt install -y nodejs

# Copying the source code to docker image
COPY index.js /home/app/index.js
COPY package-lock.json /home/app/package-lock.json
COPY package.json /home/app/package.json

WORKDIR /home/app/

RUN npm install