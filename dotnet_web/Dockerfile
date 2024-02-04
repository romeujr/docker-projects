FROM romeujr/base_application:amd64 AS base
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer.0="Romeu Junior (https://github.com/romeujr/docker-projects)"
RUN apt update && \
    apt install -y \
    wget && \
    wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod 755 /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --runtime aspnetcore --version 6.0.26 --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet && \
    rm -rf /tmp/* && \
    date +"%Y-%m-%d %H:%M:%S %Z" > /etc/build-date
ENTRYPOINT ["/usr/local/bin/main-run.sh"]
