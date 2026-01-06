FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive

# -------------------------------
# Dependencias del sistema
# -------------------------------
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    fonts-liberation \
    libnss3 \
    libatk-bridge2.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libgtk-3-0 \
    libdrm2 \
    libxshmfence1 \
    ca-certificates \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver
ENV ROBOT_RESULTS_DIR=/robot/results

WORKDIR /robot

# -------------------------------
# Dependencias Python
# -------------------------------
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# -------------------------------
# Copiar TODO lo necesario para Robot
# -------------------------------
COPY tests/ tests/
COPY resources/ resources/
COPY variables/ variables/
COPY elementos/ elementos/
COPY scripts/ scripts/

# -------------------------------
# Directorio de resultados
# -------------------------------
RUN mkdir -p results

# -------------------------------
# Ejecución
# -------------------------------
CMD ["python", "scripts/execute-tests.py"]
