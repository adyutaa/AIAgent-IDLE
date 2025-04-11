# Gunakan image Python 3.10
FROM python:3.10-slim

# Install pip dependencies yang diperlukan poetry & virtualenv
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Install Poetry
RUN pip install --no-cache-dir poetry

# Set working directory
WORKDIR /app

# Salin file konfigurasi proyek
COPY pyproject.toml poetry.lock* ./

# Konfigurasi agar tidak membuat virtualenv baru
RUN poetry config virtualenvs.create false

# Install dependencies tanpa menginstal package utama (editable mode)
RUN poetry install --no-root --extras server

# Salin seluruh kode aplikasi
COPY . .

# Port yang akan dibuka
EXPOSE 8000

# Jalankan aplikasi (mode server)
CMD ["python", "main.py", "--server", "--host", "0.0.0.0", "--port", "8000"]
