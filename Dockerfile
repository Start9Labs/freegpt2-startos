FROM ghcr.io/open-webui/open-webui:git-824966a as gui
FROM ollama/ollama:0.1.48 as ollama

COPY --from=gui /app /app
# COPY --from=gui /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2/onnx

WORKDIR /app/backend

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3.11 python3-pip pandoc netcat-openbsd curl ffmpeg libsm6 libxext6 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /root/.cache/chroma/onnx_models/all-MiniLM-L6-v2 && \
    chown root:root -R /root/.cache/chroma && \
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu --no-cache-dir && \
    pip3 install -r requirements.txt --no-cache-dir
    # python -c "import os; from sentence_transformers import SentenceTransformer; SentenceTransformer(os.environ['RAG_EMBEDDING_MODEL'], device='cpu')" && \
    # python -c "import os; from faster_whisper import WhisperModel; WhisperModel(os.environ['WHISPER_MODEL'], device='cpu', compute_type='int8', download_root=os.environ['WHISPER_MODEL_DIR'])"

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
COPY icon.png /app/build/favicon.png
COPY icon.png /app/build/logo.svg
RUN sed -i 's/WEBUI_NAME != "Open WebUI"/WEBUI_NAME != "FreeGPT-2"/g' /app/backend/config.py
RUN sed -i 's#WEBUI_FAVICON_URL = "https://openwebui.com/favicon.png"#WEBUI_FAVICON_URL = "/static/favicon.png"#g' /app/backend/config.py
RUN sed -i 's/flex w-full justify-between items-center/flex w-full justify-between items-center hidden/g' /app/build/_app/immutable/nodes/2.*.js
ADD ./scripts/check-ui.sh /usr/local/bin/check-ui.sh
RUN chmod a+x /usr/local/bin/check-ui.sh

ENV ENV=prod
ENV OPENAI_API_BASE_URL ""
ENV OPENAI_API_KEY ""
ENV WEBUI_NAME="FreeGPT-2"
ENV WEBUI_SECRET_KEY ""
ENV SCARF_NO_ANALYTICS true
ENV DO_NOT_TRACK true
ENV RAG_EMBEDDING_MODEL="all-MiniLM-L6-v2"
ENV RAG_EMBEDDING_MODEL_DEVICE_TYPE="cpu"
