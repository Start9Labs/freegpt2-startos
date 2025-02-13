FROM ghcr.io/open-webui/open-webui:0.5.10-ollama

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
COPY icon.png /app/build/static/favicon.png
COPY icon.png /app/build/static/splash.png
COPY icon.png /app/build/static/splash-dark.png

# RUN sed -i 's/WEBUI_NAME = data\["name"\]/WEBUI_NAME = "FreeGPT-2"/g' /app/backend/open_webui/config.py
# RUN sed -i 's#WEBUI_FAVICON_URL = "https://openwebui.com/favicon.png"#WEBUI_FAVICON_URL = "/static/favicon.png"#g' /app/backend/open_webui/config.py
# RUN sed -i 's/flex w-full justify-between items-center/flex w-full justify-between items-center hidden/g' /app/build/_app/immutable/nodes/2.*.js
ADD ./scripts/check-ui.sh /usr/local/bin/check-ui.sh
RUN chmod a+x /usr/local/bin/check-ui.sh

ENV ENV=prod
ENV WEBUI_NAME="FreeGPT-2"
ENV WEBUI_FAVICON_URL="/app/build/static/favicon.png"
ENV SCARF_NO_ANALYTICS=true
ENV DO_NOT_TRACK=true
ENV RAG_EMBEDDING_MODEL_DEVICE_TYPE="cpu"