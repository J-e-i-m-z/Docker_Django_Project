# Use the official slim Python 3.11 image as the base
# The slim tag indicates a minimal image, which reduces the final image size and attack surface by excluding unnecessary components.

FROM python:3.11-slim

# --- Environment variables ---

# Prevents Python from writing .pyc files (saves space)
ENV PYTHONDONTWRITEBYTECODE=1

# Ensures logs are streamed directly to the terminal (no buffering)  
ENV PYTHONUNBUFFERED=1

# Set Working Directory
# All commands below will be run inside /app directory
WORKDIR /app

# Install Dependancies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install 
COPY requirements.txt .

# Install Python dependencies without caching to keep the image small
RUN pip install --no-cache-dir -r requirement.txt gunicorn

# Copy Project code from host to container
COPY . .

# Create non-root user 
RUN useradd -m django-user

# Give ownership of the /app directory to 'django-user'
RUN chown -R django-user:django-user /app

# Switch to this non-root user (better security than running as root)
USER django-user

# Expose port
# Document that the container listens on port 8000
EXPOSE 8000

# Run the application
# Start Gunicorn, binding to all network interfaces on port 8000
# and pointing to the Django WSGI application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "hospitalmanagement.wsgi:application"]
