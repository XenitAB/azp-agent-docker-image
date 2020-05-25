# https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops

FROM ubuntu:16.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl3 \
        libicu55 \
        libunwind8 \
        wget \
        netcat \
        unzip \
        build-essential \
        ssh \
        mono-complete

# Install docker for dind.
RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update
RUN apt-get install -y moby-engine moby-cli

WORKDIR /azp

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]