# Example of a Dockerfile with common security issues
# This file is used to demonstrate what NOT to do.
# Run the linter at https://releaserun.com/tools/dockerfile-linter/

FROM ubuntu:latest

# SEC-001: Running as root (no USER directive)
# SEC-002: No HEALTHCHECK defined
# SEC-003: Hardcoded credential
ENV DB_PASSWORD=mysecretpassword123

# BP-001: Multiple RUN commands (should be combined)
RUN apt-get update
RUN apt-get install -y curl wget python3
RUN apt-get install -y git vim

# SEC-004: Using ADD instead of COPY (allows tar extraction + URL fetching)
ADD config.tar.gz /app/

# SEC-005: Fetching remote script and piping to shell
RUN curl -fsSL https://get.example.com/install.sh | bash

# SEC-006: No .dockerignore (implied by copying everything)
COPY . /app/

WORKDIR /app

# MAINT-001: No LABEL metadata
# MAINT-002: No EXPOSE directive

CMD ["python3", "app.py"]
