FROM python:3.10-alpine as builder

# Dependencies are necessary for gevents, which seems to be rebuild on an alpine base image.
RUN apk add --no-cache \
      alpine-sdk \
      libffi-dev \
    && python -m venv /opt/venv

# Make sure we use the virtualenv.
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.10-alpine

COPY --from=builder /opt/venv /opt/venv

# Make sure we use the virtualenv.
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app

COPY . .

EXPOSE 5004

CMD [ "python", "./tvhProxy.py" ]
