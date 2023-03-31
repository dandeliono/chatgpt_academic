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

# 设置运行命令
CMD ["python3", "main.py"]
