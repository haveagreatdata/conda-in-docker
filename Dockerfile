FROM continuumio/miniconda3:4.8.2

COPY environment.yml /opt/env/
RUN conda env update -n base -f /opt/env/environment.yml \
    && conda install --no-update-deps tini \ 
    && conda clean -afy

RUN useradd --shell /bin/bash my_user
USER my_user 

WORKDIR /opt/src
COPY src/ /opt/src/

ENTRYPOINT [ "tini", "-g", "--" ]
CMD [ "python" , "hello.py" ]
