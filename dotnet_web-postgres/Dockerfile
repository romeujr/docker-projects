FROM romeujr/dotnet_web:bookworm-slim AS base
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer.0="Romeu Junior (https://github.com/romeujr/docker-projects)"
ARG POSTGRES_PASSWORD
RUN apt update && \
    apt install -y \
    postgresql \
    postgresql-contrib && \
    echo "listen_addresses = '*'" >> /etc/postgresql/15/main/postgresql.conf && \
    echo "host    all             all             172.17.0.1/24           md5" >> /etc/postgresql/15/main/pg_hba.conf && \
    echo "if [ \"\$POSTGRES_PASSWORD\" = \"\" ]; then" >> /usr/local/bin/root-setup.sh && \
    echo "  echo \"You must define the environment variable for 'POSTGRES_PASSWORD'.\"" >> /usr/local/bin/root-setup.sh && \
    echo "  exit -1" >> /usr/local/bin/root-setup.sh && \
    echo "fi" >> /usr/local/bin/root-setup.sh && \
    echo "" >> /usr/local/bin/root-setup.sh && \
    echo "echo \"\"" >> /usr/local/bin/root-setup.sh && \
    echo "service postgresql start" >> /usr/local/bin/root-setup.sh && \
    echo "echo \"ALTER USER postgres WITH PASSWORD '\$POSTGRES_PASSWORD';\" | su postgres -c \"psql\"" >> /usr/local/bin/root-setup.sh && \
    echo "echo \"\"" >> /usr/local/bin/root-setup.sh && \
    echo "" >> /usr/local/bin/root-setup.sh && \
    rm -rf /tmp/* && \
    date +"%Y-%m-%d %H:%M:%S %Z" > /etc/build-date
ENTRYPOINT ["/usr/local/bin/main-run.sh"]
