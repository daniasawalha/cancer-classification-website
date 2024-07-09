# Use an official Python runtime as a parent image
FROM python:3.11-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install required Python packages
RUN pip install --no-cache-dir pandas \
    scikit-learn \
    flask \
    Pillow \
    numpy \
    mysql-connector-python \
    tensorflow==2.15.0 \
    tf-keras==2.15.0 \
    tensorflow_hub==0.16.1 \
    keras==2.15.0

# Run the command to start your application
CMD ["python", "prediction.py"]
