FROM wlchn/gostatic:latest
ENV CONFIG_FILE_PATH /srv/http
COPY en /srv/http/en
COPY cn /srv/http/cn
COPY jp /srv/http/jp
COPY _navbar.md /srv/http/
COPY _sidebar.md /srv/http/
COPY index.html /srv/http/
COPY favicon.ico /srv/http/
COPY index.css /srv/http/
COPY logo.png /srv/http/
