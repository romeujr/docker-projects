FROM debian:bookworm-slim AS base
ENV DEBIAN_FRONTEND=noninteractive
LABEL maintainer.0="Romeu Junior (https://github.com/romeujr/docker-projects)"
RUN apt update && \
    apt install -y \
    dos2unix && \
    adduser --disabled-password --gecos "" user && \
    echo "#!/bin/bash" >> /usr/local/bin/check-mounting-path.sh && \
    echo "" >> /usr/local/bin/check-mounting-path.sh && \
    echo "if ! grep -qs \"\$1 \" /proc/mounts; then" >> /usr/local/bin/check-mounting-path.sh && \
    echo "  echo \"\"" >> /usr/local/bin/check-mounting-path.sh && \
    echo "  echo \"ERROR: Missing mounting path '\$1'.\"" >> /usr/local/bin/check-mounting-path.sh && \
    echo "  echo \"\"" >> /usr/local/bin/check-mounting-path.sh && \
    echo "  exit -1" >> /usr/local/bin/check-mounting-path.sh && \
    echo "fi" >> /usr/local/bin/check-mounting-path.sh && \
    echo "" >> /usr/local/bin/check-mounting-path.sh && \
    chmod 550 /usr/local/bin/check-mounting-path.sh && \
    echo "#!/bin/bash" >> /usr/local/bin/user-run.sh && \
    echo "" >> /usr/local/bin/user-run.sh && \
    echo "user=\"\"" >> /usr/local/bin/user-run.sh && \
    echo "path=\"\"" >> /usr/local/bin/user-run.sh && \
    echo "" >> /usr/local/bin/user-run.sh && \
    echo "while [[ \$# -gt 0 ]]; do" >> /usr/local/bin/user-run.sh && \
    echo "    case \"\$1\" in" >> /usr/local/bin/user-run.sh && \
    echo "        --user=*)" >> /usr/local/bin/user-run.sh && \
    echo "            user=\"\${1#*=}\"" >> /usr/local/bin/user-run.sh && \
    echo "            ;;" >> /usr/local/bin/user-run.sh && \
    echo "        --path=*)" >> /usr/local/bin/user-run.sh && \
    echo "            path=\"\${1#*=}\"" >> /usr/local/bin/user-run.sh && \
    echo "            ;;" >> /usr/local/bin/user-run.sh && \
    echo "        *)" >> /usr/local/bin/user-run.sh && \
    echo "            ;;" >> /usr/local/bin/user-run.sh && \
    echo "    esac" >> /usr/local/bin/user-run.sh && \
    echo "    shift" >> /usr/local/bin/user-run.sh && \
    echo "done" >> /usr/local/bin/user-run.sh && \
    echo "" >> /usr/local/bin/user-run.sh && \
    echo "if [ -d \"\$path\" ]; then" >> /usr/local/bin/user-run.sh && \
    echo "  if [ -f \"\$path/run.sh\" ]; then" >> /usr/local/bin/user-run.sh && \
    echo "    chown -R \"\$user\" \"\$path\"" >> /usr/local/bin/user-run.sh && \
    echo "    chgrp -R \"\$user\" \"\$path\"" >> /usr/local/bin/user-run.sh && \
    echo "    find \"\$path\" -type d -exec chmod 0550 {} \;" >> /usr/local/bin/user-run.sh && \
    echo "    find \"\$path\" -type f -exec chmod 0440 {} \;" >> /usr/local/bin/user-run.sh && \
    echo "    chmod 550 \"\$path\"" >> /usr/local/bin/user-run.sh && \
    echo "    chmod 550 \"\$path/run.sh\"" >> /usr/local/bin/user-run.sh && \
    echo "    dos2unix \"\$path/run.sh\" >> /dev/null 2>&1" >> /usr/local/bin/user-run.sh && \
    echo "    echo \"\"" >> /usr/local/bin/user-run.sh && \
    echo "    su - \"\$user\" -c \"\$path/run.sh\"" >> /usr/local/bin/user-run.sh && \
    echo "    echo \"\"" >> /usr/local/bin/user-run.sh && \
    echo "  fi" >> /usr/local/bin/user-run.sh && \
    echo "fi" >> /usr/local/bin/user-run.sh && \
    echo "" >> /usr/local/bin/user-run.sh && \
    chmod 550 /usr/local/bin/user-run.sh && \
    echo "#!/bin/bash" >> /usr/local/bin/custom-run.sh && \
    echo "" >> /usr/local/bin/custom-run.sh && \
    chmod 550 /usr/local/bin/custom-run.sh && \
    echo "#!/bin/bash" >> /usr/local/bin/root-setup.sh && \
    echo "" >> /usr/local/bin/root-setup.sh && \
    chmod 550 /usr/local/bin/root-setup.sh && \
    echo "#!/bin/bash" >> /usr/local/bin/main-run.sh && \
    echo "" >> /usr/local/bin/main-run.sh && \
    echo "/usr/local/bin/root-setup.sh" >> /usr/local/bin/main-run.sh && \
    echo "" >> /usr/local/bin/main-run.sh && \
    echo "/usr/local/bin/custom-run.sh" >> /usr/local/bin/main-run.sh && \
    echo "" >> /usr/local/bin/main-run.sh && \
    echo "/usr/local/bin/user-run.sh --user=\"user\" --path=\"/app/user\"" >> /usr/local/bin/main-run.sh && \
    echo "" >> /usr/local/bin/main-run.sh && \
    chmod 550 /usr/local/bin/main-run.sh && \
    rm -rf /tmp/* && \
    date +"%Y-%m-%d %H:%M:%S %Z" > /etc/build-date
ENTRYPOINT ["/usr/local/bin/main-run.sh"]
