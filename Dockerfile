FROM ghcr.io/ollama-webui/ollama-webui:main as gui
FROM ollama/ollama:latest as ollama

COPY --from=gui /app /app
RUN mkdir -p /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2
COPY --from=gui /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx
RUN chown root:root -R /root/.cache/chroma

RUN apt-get update \
    && apt-get install -y --no-install-recommends uvicorn python3.11 python3-pip pandoc netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/backend

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --no-cache-dir
RUN pip3 install -r requirements.txt --no-cache-dir

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
