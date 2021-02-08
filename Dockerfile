FROM wlchn/gostatic:latest
ENV CONFIG_FILE_PATH /srv/http
COPY en-US /srv/http/en-US
COPY zh-CN /srv/http/zh-CN
COPY _sidebar.md /srv/http/
COPY index.html /srv/http/
COPY favicon.ico /srv/http/
COPY index.css /srv/http/
COPY logo.png /srv/http/
COPY accept-language-parser.js /srv/http/
