FROM python:3.11-alpine3.17
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc and-build-dependencies \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install gradio requests[socks] mdtex2html \
    && apt-get purge -y --auto-remove gcc and-build-dependencies

COPY . /gpt
WORKDIR /gpt


CMD ["python3", "main.py"]