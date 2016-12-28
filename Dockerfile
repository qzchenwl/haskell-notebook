FROM jupyter/all-spark-notebook

USER root

RUN apt-get update && apt-get install -y python-dev python-setuptools libncurses5-dev libmagic-dev libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libblas-dev liblapack-dev gcc g++
RUN curl -sSL https://get.haskellstack.org/ | sh

USER $NB_USER
ENV PATH $PATH:$HOME/.local/bin

RUN git clone https://github.com/gibiansky/IHaskell /tmp/IHaskell
RUN mkdir -pv $HOME/.stack/global-project && cp /tmp/IHaskell/stack.yaml $HOME/.stack/global-project
RUN cd /tmp/IHaskell && stack setup && stack build && stack install
RUN ihaskell install
RUN rm -rf /tmp/IHaskell

CMD ["stack", "exec", "--", "start-notebook.sh"]
