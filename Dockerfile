FROM nginx:latest

LABEL description = "Custom image for nginx Web Server"

RUN apt-get update -y

RUN apt-get install curl -y

WORKDIR /usr/share/nginx/html

COPY ./index.html /usr/share/nginx/html/index.html

VOLUME /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]