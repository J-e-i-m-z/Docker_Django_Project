FROM python:3.11-slim

# Set Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set Working Directory
WORKDIR /app

# Install Dependancies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirement.txt gunicorn

# Copy Project
COPY . .

# Create non-root user 
RUN useradd -m django-user
RUN chown -R django-user:django-user /app
USER django-user

# Expose port
EXPOSE 8000

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "hospitalmanagement.wsgi:application"]
