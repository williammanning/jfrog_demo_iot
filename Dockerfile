# Python Base Image from https://hub.docker.com/r/arm32v7/python/
#FROM arm32v7/python:2.7.13-jessie
FROM resin/raspberry-pi-alpine-python:latest

# Copy the Python Script to blink LED
COPY text_scroll.py ./

# Intall the rpi.gpio python module
RUN pip install --no-cache-dir rpi.gpio
RUN pip install --no-cache-dir Pillow
RUN pip install --no-cache-dir sense-hat

# Trigger Python script
CMD ["python", "./text_scroll.py"]
