FROM node:latest as build

WORKDIR /usr/local/app

COPY ./ /usr/local/app/

RUN npm install

RUN npm run build

FROM nginx:latest

LABEL description = "Custom image for nginx Web Server"

RUN apt-get update -y

RUN apt-get install curl -y

WORKDIR /usr/share/nginx/html

COPY --from=build /app/build /usr/share/nginx/html

VOLUME /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
