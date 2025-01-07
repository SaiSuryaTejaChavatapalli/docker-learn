### Problems ofMultiple Dev Env

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/2f71045b-46c9-404d-8768-c93f2fb57f7b/image.png)

### Docker vs Virtulization

⇒ Virtulization solves the problem of same environment, but it is heavy

⇒ Docker is light weight, because it uses your Kernal, It’s not full blown OS

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/22793616-efb2-4775-8357-195bfa119337/image.png)

### Docker version

`docker version`

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/7331639f-f2da-48fb-8f1a-6eda3422e035/image.png)

```docker
docker run -it ubuntu
```

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/0c4931cb-992d-468f-b7a7-c3fb14a2c629/image.png)

### Containers vs Images

⇒ Docker image is a configuration.

⇒ Docker container is a Isolated environment for running image.

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/fc4c90d3-5ed5-4d91-b150-ea2a9ae3479b/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/3e40726f-fd17-4ec3-ab75-13fd2c066e83/image.png)

⇒ Image can’t have any data, It’s just a config like windows.

⇒ File created in container-1 can’t be accessed in container-2, because both are separate machine.

⇒ Once container is deleted, all the data associated with container will be lost.

⇒ Each container has its own isolation level which data can’t be shared.

### Docker CLI Commands

**List all containers:**

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/1cc711af-59c4-44ea-871c-18aced656053/image.png)

**List docker images:**

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/3eaf03a1-d6a7-40c4-9db7-6e1a9b5a2e53/image.png)

```docker
docker images --help

docker version

docker info

```

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/dc1157ad-6145-4f38-ae4d-b8875d6bd91c/image.png)

### Managing Images with CLI

```docker
docker container rm <container-id>

docker images

docker image inspect

docker image rm <image-name>

docker image pull alpine

docker image prune

docker image --help
```

### Managing containers with CLI

```docker
docker container --help

docker run -it --name my-container ubuntu

docker container kill <id>

docker container rm <id>

docker container rm --help

docker run -it ubuntu ls  // Entry point

docker run -it busybox ping google.com

docker run --help

```

### Docker build image

```docker
docker build -t <name> <context>

docker build -t my-app .

```

## Caching in Docker file

⇒ in docker file, whatever the layer you changed, the above layers will be cached and only below layers will run again.

⇒ So make sure you put `npm`install above lines, so it won’t happen every time, It will happen only if `package.json` changes

⇒ Source code change will not make `npm install` again, because there is no need, packages needs to install only when something changes in packages/libraries

## Port Mapping

```docker
docker run -it -p 8000:8000 my-app
```

⇒ Port in container is private, we need to map with external computer port, then only we can access those app.

### Multiple port mapping

```docker
docker run -it -p 3000:8000 -p 3001:9000 -p 3002:8001 my-app
```

### Automating port mapping

```docker
// In docker file
// ..................

RUN npm install

EXPOSE 8000 3000 4000

CMD ["npm","start"]
```

```docker
docker run -it -P my-app
```

### Remove container after exiting

⇒ Data is also lost here when exiting

```docker
docker run -it -P -rm my-app
```

### Detached mode

```docker
docker run -itd -P -rm my-app
```

⇒ it will give us an id

⇒ we can use that id to stop that container.

⇒ Container running in background

⇒ we are not stuck to do other things in terminal, because generally there is one terminal in deploying servers

```docker
docker stop <id>
```

## Docker publish

⇒ Create an account in docker hub

⇒ Create a repository

```docker
docker build -t <unique-image-name>/<name in your docker hub repo name> .

docker login

docker push <image-name>
```

⇒ then we can pull using docker pull.

### Another way

```docker
docker tag my-app sst/node-app
docker push sst/node-app
```

## Docker tag

```docker
docker tag my-app sst/node-app:v1
docker push sst/node-app:v1
```

## Multi Stage Builds

```docker
// OLD File
FROM node:20-alpine3.19

WORKDIR /home/app

COPY package*.json .
COPY tsconfig.json .

RUN npm install

COPY src/ src/

RUN npm run build

CMD [ "npm", "start" ]
```

```docker
// Multi Stage Build
FROM node:20-alpine3.19 as base

# Stage 1: Build Stuff
FROM base as builder

WORKDIR /home/build

COPY package*.json .
COPY tsconfig.json .

RUN npm install

COPY src/ src/

RUN npm run build

# Stage 2: Runner
FROM base as runner

WORKDIR /home/app

COPY --from=builder /home/build/dist dist/
COPY --from=builder /home/build/package*.json .

RUN npm install --omit=dev

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs

USER nodejs

EXPOSE 8000
ENV PORT=8000

CMD [ "npm", "start" ]

```

⇒ After the build we don’t need files in source directory.

⇒ First stage will delete after completed

⇒ Saves memory size (Optimization Docker file)

⇒ dev dependencies(TYPESCRIPT, types) are not needed in production, so it is redundant to have those dependencies

### Manually build docker file

⇒ By default it takes `Dockerfile` only, if we want particular file to build

```docker
docker build -t ts-app-old -f Dockerfile.old .
```

## Secure User Management

⇒ We should never run CMD ["npm","start"] as admin, by default it runs as a admin. we can create users in docker image using below commands

```docker

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs
// Creates a group and adds a user nodejs
USER nodejs
// login as user
```

⇒ now app is run as a user, user doesn't have root permissions
⇒ if we run as an root user, there are security vulnerabilities

## Env Variables in Docker Image

⇒ -e tag, we can give env variables, if there are any env variable use in code

```docker
ENV PORT=8000
```

```docker
# Environemnt variable
 docker run -it -p 3000:3000  -e PORT=3000 ts-node
 docker run -it -p 3000:3000  --envfile=./.env  ts-node
```

# Docker Bridge Mode Networking

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/03a83ece-878b-4417-961b-c2c659849ae1/image.png)

⇒ List docker networks

```sql
docker network ls
```

⇒ Default network is bridge

```sql
docker run -itd --rm --name=my-container busybox
```

```sql
docker network inspect bridge
```

⇒ from `container_two` pinging my-container

```sql
docker exec container_two ping 172.17.0.2
```

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/e9f891d3-86a6-4ba7-b1a1-22443970310a/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/f79f5a4e-e6af-4a1d-bcdc-c6d22dcc63e1/image.png)

# Custom Bridge networking

### Create a network bridge

```sql
docker network create milkyway
```

```sql
docker run -itd --network=milkyway --rm --name=spiderman busybox
```

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/54dd01fb-4217-4a69-bf64-0577d50a368f/fc91722b-fbac-4657-9b37-344bae737d7a/image.png)

→ spiderman container from `milkyway` bridge can’t talk to the `container_two` container in default bridge network, because they are in isolated environment.

→ But they can talk to other containers under same network.

→ Containers under custom network can ping using names also, ip address should not need to know, it will automatically figure out because of automatic DNS resolution

⇒ On the fly you can attach the containers

```sql
docker network connect milkyway container_two
```

```sql
docker inspect milkyway
```

Now we added container_two in milkyway network bridge, spiderman can ping container_two, because they are both under same network.

```sql
docker exec spiderman ping container_two
```

⇒ Similarly, we can disconnect container from custom network bridge

```sql
docker network disconnect milkyway container_two
```

⇒ In production we should always use user-defined network bridge.

### Remove custom network bridge

```sql
docker network rm milkyway
```

.
