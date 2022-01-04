FROM jupyter/datascience-notebook

ENV NODE_OPTIONS="--max-old-space-size=4096"
ADD install_extensions.sh /

CMD ["/bin/bash", "/install_extensions.sh"]
