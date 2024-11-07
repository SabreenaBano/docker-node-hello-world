FROM node:16-alpine

# Install build dependencies and timezone package in one step for efficiency
RUN apk update && apk add --no-cache build-base libpq-dev tzdata

# Set the timezone (adjust if necessary)
RUN cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
    echo "Australia/Sydney" > /etc/timezone && \
    apk del tzdata

# Create the application directory
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# Set npm to use a longer timeout for installation
RUN npm config set fetch-timeout 60000

# Copy package.json and install dependencies
COPY package.json /usr/src/app/
RUN npm install --verbose

# Copy the rest of the application code
COPY . /usr/src/app

# Testing: Printed on screen to test that we are seeing the Dockerized version of the app (as opposed to localhost)
ENV RUNNING_DOCKER=true

EXPOSE 3000

CMD [ "npm", "start" ]

