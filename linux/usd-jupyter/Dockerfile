ARG from_image=dockerusd/usd-lite
FROM ${from_image}

ARG NB_USER=jovyan
ARG NB_UID=1000

RUN useradd -m -u ${NB_UID} ${NB_USER} && \
    su -c "echo '%${NB_USER} ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers"

ENV USER=${NB_USER} \
    NB_UID=${NB_UID} \
    HOME=/home/${NB_USER}

RUN pip3 install --no-cache-dir notebook==5.* jupyterlab

COPY usd-jupyter/jupyter_notebook_config.py /etc/jupyter/

USER ${NB_USER}

RUN mkdir /home/${NB_USER}/work
WORKDIR /home/${NB_USER}/work

RUN jupyter notebook --generate-config

EXPOSE 8888

ENTRYPOINT [ "jupyter", "lab" ]
