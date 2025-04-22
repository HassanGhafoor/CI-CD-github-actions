# Build stage: Full Debian image with exact Node.js version
FROM node:23.11.0-bullseye AS build

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build

# Serve stage: lightweight Nginx Alpine
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
