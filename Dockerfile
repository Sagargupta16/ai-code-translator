# Use the official Node.js image as the base image
FROM node:24-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency manifests first (better layer caching)
COPY package.json package-lock.json ./

# Install the dependencies
RUN npm ci --omit=dev

# Copy only the application source and build config (avoids recursively
# copying secrets/env/git into the image)
COPY components ./components
COPY pages ./pages
COPY public ./public
COPY styles ./styles
COPY types ./types
COPY utils ./utils
COPY next.config.js postcss.config.js tailwind.config.js tsconfig.json ./

# Run as non-root user for security
USER node

# Expose the port the app will run on (Next.js defaults to 3000)
EXPOSE 3000

# Start the application
CMD ["npm", "run", "dev"]
