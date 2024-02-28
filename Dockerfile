FROM ghcr.io/open-webui/open-webui:git-5745b9c as gui
FROM ollama/ollama:0.1.27 as ollama

COPY --from=gui /app /app
COPY --from=gui /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx

WORKDIR /app/backend

RUN apt-get update && \
    apt-get install -y --no-install-recommends uvicorn python3.11 python3-pip pandoc netcat-openbsd && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2 && \
    chown root:root -R /root/.cache/chroma && \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --no-cache-dir && \
    pip3 install -r requirements.txt --no-cache-dir

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
COPY icon.png /app/backend/static/favicon.png
