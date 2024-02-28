#!/bin/sh

printf "\n\n [i] Starting FreeGPT-2 ...\n\n"

_term() {
  echo "Caught TERM signal!"
  kill -TERM "$ollama_process" 2>/dev/null
  kill -TERM "$webui_process" 2>/dev/null
}

ollama serve &
ollama_process=$!

exec /app/backend/start.sh &
webui_process=$!

trap _term TERM

wait $ollama_process $webui_process
