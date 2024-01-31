FROM romeujr/base_application:amd64 AS base
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer.0="Romeu Junior (https://github.com/romeujr/docker-projects)"
RUN apt update && \
    apt install -y \
    wget && \
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb && \
    dpkg -i /tmp/packages-microsoft-prod.deb && \
    apt update && \
    apt install -y \
    aspnetcore-runtime-6.0 && \
    rm -rf /tmp/* && \
    date +"%Y-%m-%d %H:%M:%S %Z" > /etc/build-date
ENTRYPOINT ["/usr/local/bin/main-run.sh"]
