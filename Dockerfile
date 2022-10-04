FROM rocker/verse:4.2.1

MAINTAINER Deepak Tanwar (dktanwar@hotmail.com)

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

COPY .bashrc /root/.bashrc
WORKDIR /project

ENV RENV_VERSION 0.15.5
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"
RUN R -e "remotes::install_github('anthonynorth/rscodeio')"

#COPY renv.lock renv.lock
#RUN R -e "renv::restore()"


RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget \
    nano \
    emacs \
    rsync

# Installing Conda
## Thanks: ContinuumIO/docker-images

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet -O ~/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh \
    && /bin/bash ~/miniconda3.sh -b -p /opt/conda\
    && rm ~/miniconda3.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH /root/miniconda3/bin:$PATH



SHELL ["/bin/bash", "-c"]

#COPY bioinfo.yml .
RUN . /root/.bashrc && \ 
    conda create -n bioinfo -y && \
    conda activate bioinfo

RUN conda install mamba -y    
#RUN mamba env update -n bioinfo --file bioinfo.yml && mamba clean -a -y
#RUN rm /opt/conda/envs/bioinfo/bin/R /opt/conda/envs/bioinfo/bin/Rscript
ENV PATH /opt/conda/envs/bioinfo/bin:$PATH
RUN echo "conda activate bioinfo" >> ~/.bashrc

# Installing Tini

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=0.19.0 && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

## automatically link a shared volume for kitematic users
VOLUME /home/rstudio/kitematic

SHELL ["/bin/bash", "-c"]
ENTRYPOINT [ "/usr/bin/tini", "--" ]

CMD [ "/bin/bash" ]
CMD [ "R" ]
CMD [ "/init" ]

EXPOSE 8787
