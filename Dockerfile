# Stage 1: Build Angular application
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# Build Angular app (production)
RUN npm run build --prod

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy Angular build output to Nginx html directory
# IMPORTANT: Replace <project-name> with the actual folder name inside dist/
COPY --from=build /app/dist/angulardemo  /usr/share/nginx/html

# Optional: custom Nginx config for Angular routing
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
