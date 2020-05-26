FROM ubuntu:19.10
RUN apt-get update -y && apt-get install -y \
python \
python-pip \
python-dev \
build-essential
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]