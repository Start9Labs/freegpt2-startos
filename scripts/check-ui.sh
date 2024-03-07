#!/bin/sh

CHCK='curl -skf http://free-gpt.embassy:8080 >/dev/null 2>&1'

eval "$CHCK"
exit_code=$?

while [ "$exit_code" -ne 0 ]; do
    echo "Initializing..." >&2
    exit 61
    sleep 5
    eval "$CHCK"
    exit_code=$?
done

if [ "$exit_code" -ne 0 ]; then
    echo "Not available..." >&2
    exit 1
fi
