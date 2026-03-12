# Example of a well-written, secure Dockerfile
# This file follows all 18 rules checked by the ReleaseRun Dockerfile Linter
# Run the linter at https://releaserun.com/tools/dockerfile-linter/

FROM python:3.12-slim

# MAINT-001: Add metadata labels
LABEL maintainer="you@example.com"
LABEL version="1.0.0"
LABEL description="Production-ready Python application container"

# Create app user first (SEC-001: don't run as root)
RUN groupadd --gid 1001 appgroup && \
    useradd --uid 1001 --gid appgroup --shell /bin/bash --create-home appuser

# Set working directory
WORKDIR /app

# BP-002: Copy dependency files first for cache efficiency
COPY requirements.txt .

# PF-001: Use --no-cache-dir to reduce image size
# BP-001: Combine RUN commands; PF-002: Clean up apt cache
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove build-essential \
    && rm -rf /var/lib/apt/lists/*

# BP-002: Copy app code after dependencies (better cache behaviour)
COPY --chown=appuser:appgroup . .

# MAINT-002: Document the port
EXPOSE 8000

# SEC-001: Switch to non-root user
USER appuser

# SEC-002: Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

CMD ["python3", "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
