# Stage 1: Build Angular app
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app (production build)
RUN npm run build --prod

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy built Angular files from Stage 1
COPY --from=build /app/dist/<your-angular-app-name> /usr/share/nginx/html

# Optional: custom Nginx config for Angular routing
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
