# Flask app example definition
FROM python:3.8

ENV COURSE=DEVCORE

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt
EXPOSE 5000

ENTRYPOINT [ "python3" ]
CMD [ "program.py" ]
