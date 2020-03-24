# Use deprecated VSTS Agent
# More info here: https://github.com/microsoft/vsts-agent-docker/
FROM mcr.microsoft.com/azure-pipelines/vsts-agent:ubuntu-16.04-docker-18.06.1-ce-standard

# Update packages
RUN apt-get update \
    && apt-mark hold mysql-server \
    && apt-mark hold mysql-server-5.7 \
    && apt-get upgrade -y

# Update azure-cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Update powershell
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell

# Cleanup
RUN apt-get autoremove -y \
    && apt-get autoclean -y\
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/apt/sources.list.d/*