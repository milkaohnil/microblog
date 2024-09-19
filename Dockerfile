FROM python:3.9

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN pip install gunicorn pymysql cryptography

COPY app app
COPY migrations migrations
COPY microblog.py config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP microblog.py
RUN flask translate compile
CMD ["/bin/bash","flask db migrate"]

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
