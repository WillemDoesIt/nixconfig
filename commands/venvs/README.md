---
 - date: 2025.09.14 - 16:10
---


The scripts are used to run, stop, and uninstall the webview of ollama. In case things change read bellow for more details.

---

This directory exists for the purpose of running Python projects that need imperatively installed packages such through `pip`. 

As of writting the only subdirectory or "venv", is that for `open-webui`, which whilst is a nixpkg, has not installed well on my machine, so I went with this route. That is why there are scripts to `deploy.sh`, `stop.sh` the depolyment, and `uninstall.sh` for when the nixpkg does work well enough for me to abandon this.

You will have to research or ask an LLM if you wish to create another, I didn't think to document my process well, whoops :/
