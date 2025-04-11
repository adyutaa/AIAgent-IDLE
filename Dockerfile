# Gunakan image python 3.10 (karena poetry-nya butuh Python <3.11)
FROM python:3.10-slim

# Install dependencies dasar
RUN apt-get update && apt-get install -y curl build-essential

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Set PATH untuk poetry
ENV PATH="/root/.local/bin:$PATH"

# Buat working directory
WORKDIR /app

# Salin semua file ke dalam container
COPY . .

# Install dependencies tanpa root install dan include server extras
RUN poetry install --no-root --extras server

# Jalankan app saat container di-run
CMD ["poetry", "run", "python", "main.py", "--server", "--host", "0.0.0.0", "--port", "8000"]
