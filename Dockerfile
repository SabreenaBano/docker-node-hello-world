FROM node:16-alpine

# Use a more lightweight and updated image (e.g., alpine-based Node.js image)
RUN apk update && apk add --no-cache build-base libpq-dev

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# Set the timezone (adjust if necessary)
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime \
    && echo "Australia/Sydney" > /etc/timezone \
    && apk del tzdata

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

# Testing: Printed on screen to test that we are seeing the Dockerized version of the app (as opposed to localhost)
ENV RUNNING_DOCKER=true

EXPOSE 3000
CMD [ "npm", "start" ]


