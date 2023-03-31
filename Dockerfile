# 使用Alpine Linux作为基础镜像
FROM python:3.11-slim-buster

# 安装依赖项
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libc6-dev && \
    rm -rf /var/lib/apt/lists/*

# 安装Python依赖项
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir gradio requests[socks] mdtex2html && \
    rm -rf /root/.cache/pip

# 复制应用程序代码并设置工作目录
COPY . /gpt
WORKDIR /gpt

# API key for using the GPT-3 API
ENV API_KEY="None"

# Flag to indicate whether to use a proxy server
ENV USE_PROXY=False

# Timeout for HTTP requests, in seconds
ENV TIMEOUT_SECONDS=25

# Port for running the web app
ENV WEB_PORT=80

# Maximum number of retries for a failed request
ENV MAX_RETRY=2

# Name of the GPT-3 model to use
ENV LLM_MODEL="gpt-3.5-turbo"

# Number of concurrent requests to send to the GPT-3 API
ENV CONCURRENT_COUNT=100

# Username for accessing the web app
ENV USERNAME=""

# Password for accessing the web app
ENV PASSWORD=""


# 设置运行命令
CMD ["python3", "main.py"]
