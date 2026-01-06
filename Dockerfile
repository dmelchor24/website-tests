FROM python:3.11-slim

# -------------------------------
# Dependencias del sistema
# -------------------------------
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

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
