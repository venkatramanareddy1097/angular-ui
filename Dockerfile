# Stage 1: Build the Angular application
FROM node:16.14 AS builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the entire project
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create a lightweight container to serve the built application
FROM nginx:1.21.0

# Copy the built application from the previous stage
COPY --from=builder /app/dist/angular-demo /usr/share/nginx/html

# Expose port 80 for the NGINX server
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
