# Take Base Image as Ubuntu
# FROM ubuntu // Ubuntu is bloated


#Node installed on alpine machine

FROM node:22.12-alpine3.21  

WORKDIR /home/app/

# Copying the source code to docker image
COPY package-lock.json package-lock.json
COPY package.json package.json


COPY index.js index.js

RUN npm install

CMD ["npm","start"]