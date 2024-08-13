FROM python:3.10
WORKDIR /app
COPY . /app/
RUN pip3 install -r requirements.txt
pip install ffmpeg-python
CMD ["python3", "bot.py"]
