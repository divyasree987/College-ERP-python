#------------------ Stage 1: Builder ---------

FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


#------------------ Stage 2: Runtime ---------

FROM python:3.11-slim

WORKDIR /app

#Copy only installed dependencies from builder

COPY --from=builder /install /usr/local

# Copy project source code

COPY . .

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]
