# Use Python 3.10
FROM python:3.10-slim

# Install required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install pip dependencies
RUN pip install --no-cache-dir --upgrade pip

# Install Poetry - specific version to avoid compatibility issues
RUN pip install --no-cache-dir poetry==1.6.1

# Copy only dependency files first to leverage Docker cache
COPY pyproject.toml poetry.lock* ./

# Configure poetry to not use virtual environments
RUN poetry config virtualenvs.create false

# Install dependencies with a more reliable approach
RUN poetry install --no-interaction --no-ansi --no-root --extras server

# Copy the rest of the application
COPY . .

# Expose the port
EXPOSE 8000

# Run the application
CMD ["python", "main.py", "--server", "--host", "0.0.0.0", "--port", "8000"]