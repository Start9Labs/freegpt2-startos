FROM ghcr.io/open-webui/open-webui:0.6.5-ollama

COPY icon.png /app/build/static/favicon.png
COPY icon.png /app/build/static/splash.png
COPY icon.png /app/build/static/splash-dark.png

ENV ENV=prod
ENV WEBUI_NAME="Ollama"
ENV WEBUI_FAVICON_URL="/app/build/static/favicon.png"
ENV SCARF_NO_ANALYTICS=true
ENV DO_NOT_TRACK=true
ENV RAG_EMBEDDING_MODEL_DEVICE_TYPE="cpu"