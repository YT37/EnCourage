FROM python:3.11.7-bookworm

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=src/app.py

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]