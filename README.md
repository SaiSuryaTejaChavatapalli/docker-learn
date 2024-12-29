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
```
