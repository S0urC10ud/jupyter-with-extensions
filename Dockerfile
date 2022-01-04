FROM jupyter/datascience-notebook

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN declare -a pip_extensions=( \
                    "jupyterlab-spellchecker" \
                    "aquirdturtle_collapsible_headings" \
                    "jupyterlab==3" \
                    "jupyterlab-git==0.22.1" \
                )
RUN declare -a jupyter_extensions=( \
                    "@jupyter-widgets/jupyterlab-manager" \
                    "bqplot" \
#                    "element4" \
#                    "jupyterlab_tensorboard" \
                    "jupyterlab-kernelspy" \
#                    "@jupyterlab/plotly-extension" \
                    "jupyterlab-chart-editor" \
                    "plotlywidget" \
                    "@jupyterlab/latex" \
                    "jupyter-matplotlib" \
                    "jupyterlab-drawio" \
                    "jupyter-leaflet" \
                    "qgrid" \
                )

RUN for ext in "${jupyter_extensions[@]}"; do jupyter labextension install "$ext" --no-build; done
RUN for ext in "${pip_extensions[@]}"; do pip install "$ext"; done

RUN  jupyter lab build && \
        jupyter lab clean && \
        jlpm cache clean && \
        npm cache clean --force && \
        rm -rf $HOME/.node-gyp && \
        rm -rf $HOME/.local && \
    fix-permissions $CONDA_DIR $HOME
