FROM wlchn/gostatic:latest
ENV CONFIG_FILE_PATH /srv/http
COPY en-US /srv/http/en-US
COPY zh-CN /srv/http/zh-CN
COPY ja-JP /srv/http/ja-JP
COPY en-US /srv/http/zh-CN/perpetual-tech.md
COPY _sidebar.md /srv/http/
COPY index.html /srv/http/
COPY favicon.ico /srv/http/
COPY index.css /srv/http/
COPY logo.png /srv/http/
