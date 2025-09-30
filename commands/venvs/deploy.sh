#!/usr/bin/env bash
cd "$(dirname "$0")"
export LD_LIBRARY_PATH=/nix/store/jwlvd2j4bl0wyn48kjbkk6bjbqkcf33l-gcc-14.3.0-lib/lib64:$LD_LIBRARY_PATH
source open-webui/bin/activate
nohup ollama serve >/dev/null 2>&1 &
echo "Serving ollama..."
nohup open-webui serve >/dev/null 2>&1 &
echo "Serving webui..."
sleep 3
nohup xdg-open http://localhost:8080
