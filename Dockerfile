# Install the app dependencies in a full Node docker image
FROM registry1.dso.mil/ironbank/opensource/nodejs/nodejs18@sha256:73d69d7fe8dd067bd13b45b8c2d48b2d2624bed1e1ba61b0f5843869763a9688
# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm ci

# Copy the dependencies into a Slim Node docker image
FROM registry1.dso.mil/ironbank/opensource/nodejs/nodejs18@sha256:73d69d7fe8dd067bd13b45b8c2d48b2d2624bed1e1ba61b0f5843869763a9688

# Install app dependencies
COPY --from=0 /opt/app-root/src/node_modules /opt/app-root/src/node_modules
COPY . /opt/app-root/src

ENV NODE_ENV production
ENV PORT 3001

CMD ["npm", "start"]
