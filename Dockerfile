FROM jupyter/datascience-notebook

ENV NODE_OPTIONS="--max-old-space-size=4096"
COPY install_extensions.sh /
RUN /bin/bash /install_extensions.sh