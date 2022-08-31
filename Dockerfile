# Install the app dependencies in a full Node docker image
FROM registry1.dso.mil/ironbank/opensource/apache/apache2@sha256:1d14c8ddf14078dbdead5ac88b1c86d96c2e60709ccc4a56bbb188109f5a47f7

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm ci

# Copy the dependencies into a Slim Node docker image
FROM registry1.dso.mil/ironbank/opensource/apache/apache2@sha256:1d14c8ddf14078dbdead5ac88b1c86d96c2e60709ccc4a56bbb188109f5a47f7

# Install app dependencies
COPY --from=0 /opt/app-root/src/node_modules /opt/app-root/src/node_modules
COPY . /opt/app-root/src

ENV NODE_ENV production
ENV PORT 3001

CMD ["npm", "start"]
