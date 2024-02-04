FROM romeujr/base_application:amd64 AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    libicu_package=$(apt list "libicu*" 2>/dev/null | grep -E "^libicu[0-9]+" | awk '{print $1}' | sort -V | tail -n 1) && \
    apt install -y \
    wget \
    $libicu_package && \
    wget https://dot.net/v1/dotnet-install.sh -O /tmp/dotnet-install.sh && \
    chmod 755 /tmp/dotnet-install.sh && \
    /tmp/dotnet-install.sh --runtime aspnetcore --version 6.0.26 --install-dir /usr/share/dotnet && \
    ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet && \
    rm -rf /tmp/* && \
    date +"%Y-%m-%d %H:%M:%S %Z" > /etc/build-date
ENTRYPOINT ["/usr/local/bin/main-run.sh"]
