FROM node:22.12-alpine3.20
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/

RUN npm i -g pnpm@9.15.0

COPY package.json pnpm-lock.yaml ./
RUN pnpm add -g node-gyp
RUN pnpm config set fetch-retry-maxtimeout 600000 -g && pnpm add
ENV PATH=/opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN ["node", "--run", "build"]
EXPOSE 1337
CMD ["node", "--run", "develop"]
