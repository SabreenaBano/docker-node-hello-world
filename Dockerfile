FROM node:14

# Use a more lightweight and updated image (e.g., alpine-based Node.js image)
RUN apk update && apk add --no-cache build-base libpq-dev libkrb5-dev

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# Set the timezone (adjust if necessary)
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Australia/Sydney /etc/localtime

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

# Testing: Printed on screen to test that we are seeing the Dockerised version of the app (as opposed to localhost)
ENV RUNNING_DOCKER true

EXPOSE 3000
CMD [ "npm", "start" ]



