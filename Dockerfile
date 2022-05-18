FROM node:10

# Create app directory
WORKDIR /usr/src/electron-release-server


RUN export HTTP_PROXY=http://192.168.30.26:10809 && export HTTPS_PROXY=http://192.168.30.26:10809

# Install app dependencies
COPY package.json .bowerrc bower.json /usr/src/electron-release-server/
RUN npm install \
  && ./node_modules/.bin/bower install --allow-root \
  && npm cache clean --force \
  && npm prune --production

# Bundle app source
COPY . /usr/src/electron-release-server

COPY config/docker.js config/local.js

EXPOSE 80

RUN export HTTP_PROXY= && export HTTPS_PROXY=

CMD [ "npm", "start" ]
