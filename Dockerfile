# Stage 1: Build Angular app
FROM node:18 AS build

WORKDIR /app

# Copy only package files first
COPY package*.json ./

RUN npm install

# Copy source code (excluding node_modules via .dockerignore)
COPY . .

RUN npm run build --prod

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy only the Angular build output
COPY --from=build /app/dist/demoangular /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
