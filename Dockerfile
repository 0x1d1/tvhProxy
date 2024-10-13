FROM python:3.13.0-alpine AS base

FROM base AS builder

WORKDIR /app
COPY requirements.txt ./

ENV PATH="/opt/venv/bin:$PATH"
RUN python -m venv /opt/venv \
 && pip install --no-cache-dir -r requirements.txt

FROM base

COPY --from=builder /opt/venv /opt/venv

WORKDIR /app
COPY . .

ENV PATH="/opt/venv/bin:$PATH"
CMD [ "python", "./tvhProxy.py" ]

EXPOSE 5004
