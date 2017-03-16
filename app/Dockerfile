FROM smebberson/alpine-nodejs:6.0.0

# Default to running in development mode.
ENV NODE_ENV="development"

# Add the files needed to install NPM modules.
ADD root/app/package.json /app/

# Install the NPM modules.
RUN cd /app && \
    npm install --production

# Copy across the source for the app
ADD root /

# Expose the port
EXPOSE 4000
