FROM python:3.10

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    yasm \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libavresample-dev \
    libx264-dev \
    libx265-dev \
    libvpx-dev \
    libfdk-aac-dev \
    libmp3lame-dev \
    libopus-dev \
    wget \
    git

# Download and install FFmpeg from source
RUN cd /usr/local/src && \
    git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg && \
    cd ffmpeg && \
    ./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libvpx --enable-libfdk-aac --enable-libmp3lame --enable-libopus && \
    make -j$(nproc) && \
    make install

# Set the working directory
WORKDIR /app

# Copy the application files to the container
COPY . /app/

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Command to run the bot
CMD ["python3", "bot.py"]
