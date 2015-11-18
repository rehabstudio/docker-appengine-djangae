FROM debian:wheezy
MAINTAINER Ryan Grieve <ryan@rehabstudio.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apt-transport-https \
        build-essential \
        libxslt1-dev \
        python-imaging \
        python-numpy \
        python-dev \
        python-pip \
        git \
        sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install the Appengine Python SDK
ADD gaesdk_download.py /tmp/gaesdk_download.py
RUN /tmp/gaesdk_download.py 1.9.26 && \
    rm -rf /tmp/*
ENV PATH /opt/google_appengine:$PATH

ADD . /src
WORKDIR /src


EXPOSE 8000 8001 8002

ENTRYPOINT ["python", "manage.py"]


ONBUILD ADD ./requirements.txt .
ONBUILD RUN pip install -r requirements.txt -t sitepackages

ONBUILD ADD ./*.yaml /src/
ONBUILD ADD ./app /src/app