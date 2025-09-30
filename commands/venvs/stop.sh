#!/usr/bin/env bash
cd "$(dirname "$0")"
PID=$(ps aux | grep '[o]pen-webui serve' | awk '{print $2}')
if [ -n "$PID" ]; then
    kill "$PID"
    echo "open-webui stopped."
else
    echo "No running open-webui process found."
fi

