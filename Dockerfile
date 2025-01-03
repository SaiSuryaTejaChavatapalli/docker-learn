#  Multi Stage Build
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
# We should never run CMD ["npm","start"] as admin. wecan create users in docker image using below commands
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nodejs
# now app is run as a user, user doesn't have root permissions
# if we run as an root user, there are security vunerelbilties

USER nodejs


EXPOSE 8000
# Environemnt variable
# docker run -it -p 3000:3000  -e PORT=3000 ts-node
# docker run -it -p 3000:3000  --envfile=./.env  ts-node
ENV PORT=8000

CMD [ "npm", "start" ]
