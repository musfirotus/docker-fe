FROM node:latest as build-stage
WORKDIR /app

COPY package.json ./
RUN npm install --check-files
COPY . .
RUN npm run build

# production stage
FROM nginx as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
