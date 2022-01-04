FROM jupyter/datascience-notebook

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN declare -a extensions=( \
                    "jupyterlab-spellchecker" \
                    "@jupyter-widgets/jupyterlab-manager" \
                    "bqplot" \
                    "element4" \
                    "@jupyterlab/git" \
                    "jupyterlab_tensorboard" \
                    "jupyterlab-kernelspy" \
                    "@jupyterlab/plotly-extension" \
                    "jupyterlab-chart-editor" \
                    "plotlywidget" \
                    "@jupyterlab/latex" \
                    "jupyter-matplotlib" \
                    "jupyterlab-drawio" \
                    "jupyter-leaflet" \
                    "qgrid" \
                    "aquirdturtle_collapsible_headings" \
                )
RUN for ext in "${extensions[@]}" \
    do \
        jupyter labextension install "$ext"  --no-build && \
    done

RUN  jupyter lab build && \
        jupyter lab clean && \
        jlpm cache clean && \
        npm cache clean --force && \
        rm -rf $HOME/.node-gyp && \
        rm -rf $HOME/.local && \
    fix-permissions $CONDA_DIR $HOME