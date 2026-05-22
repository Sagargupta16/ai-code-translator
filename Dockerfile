# Use the official Node.js image as the base image
FROM node:24-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency manifests first (better layer caching)
COPY package.json package-lock.json ./

# Install the dependencies
RUN npm ci --omit=dev

# Copy only the application source (not secrets, .env, node_modules)
COPY public ./public
COPY src ./src
COPY next.config.* tsconfig.json ./

# Run as non-root user for security
USER node

# Expose the port the app will run on
EXPOSE 3001

# Start the application
CMD ["npm", "run", "dev"]
