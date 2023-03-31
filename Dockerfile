FROM python:3.11

RUN pip3 install gradio requests[socks] mdtex2html

COPY . /gpt
WORKDIR /gpt


CMD ["python3", "main.py"]