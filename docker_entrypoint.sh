#!/bin/sh

printf "\n\n [i] Starting Ollama ...\n\n"

_term() {
  echo "Caught SIGTERM signal!"
  kill -SIGTERM "$ollama_process" 2>/dev/null
  kill -SIGTERM "$webui_process" 2>/dev/null
}

ollama serve &
ollama_process=$!

exec /app/backend/start.sh &
webui_process=$!

trap _term SIGTERM

wait $ollama_process $webui_process
