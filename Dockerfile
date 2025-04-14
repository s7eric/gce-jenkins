
# Use the official nginx image with Alpine Linux for a small footprint
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Create a non-root user for better security
RUN adduser -D -H -u 1000 -s /sbin/nologin www-data

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy HTML application files
COPY . /usr/share/nginx/html/

# Remove any unnecessary files
RUN rm -rf Dockerfile README.md .git* .dockerignore || true

# Set proper permissions
RUN chown -R www-data:www-data /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Switch to non-root user for better security
USER www-data

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]