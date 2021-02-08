FROM nginx:alpine

RUN rm /etc/nginx/conf.d/*
COPY nginx/mcdex.conf /etc/nginx/conf.d/

COPY en-US /srv/http/en-US
COPY zh-CN /srv/http/zh-CN
COPY _sidebar.md /srv/http/
COPY index.html /srv/http/
COPY favicon.ico /srv/http/
COPY index.css /srv/http/
COPY logo.png /srv/http/
COPY accept-language-parser.js /srv/http/

CMD ["nginx", "-g", "daemon off;"]
