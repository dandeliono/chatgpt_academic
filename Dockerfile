# 第一阶段：安装依赖项和 Python 依赖项
FROM python:3.11-slim-buster AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libc6-dev && \
    rm -rf /var/lib/apt/lists/*
ENV PATH="/install/bin:${PATH}"
WORKDIR /install
COPY requirements.txt .
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --prefix=/install --no-cache-dir gradio requests[socks] mdtex2html pymupdf && \
    rm -rf /root/.cache/pip

# 第二阶段：构建最终镜像
FROM python:3.11-slim-buster

# 复制应用程序代码并设置工作目录
COPY . /gpt
WORKDIR /gpt

# 从第一阶段复制依赖项
COPY --from=builder /install /usr/local

# 设置环境变量
ENV API_KEY="None"
ENV USE_PROXY=False
ENV TIMEOUT_SECONDS=25
ENV WEB_PORT=80
ENV MAX_RETRY=2
ENV LLM_MODEL="gpt-3.5-turbo"
ENV CONCURRENT_COUNT=100
ENV USERNAME=""
ENV PASSWORD=""

# 设置运行命令
CMD ["python3", "main.py"]
