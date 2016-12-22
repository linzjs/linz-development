FROM smebberson/alpine-nginx:3.0.0

# Default to running in development mode.
ENV NODE_ENV="development"

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Add root
ADD root /
