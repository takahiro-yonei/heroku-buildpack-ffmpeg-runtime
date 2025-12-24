#!/usr/bin/env bash

PULSE_DIR="/app/.apt/usr/lib/x86_64-linux-gnu/pulseaudio"
if [ -d "$PULSE_DIR" ]; then
  export LD_LIBRARY_PATH="$PULSE_DIR:${LD_LIBRARY_PATH:-}"
fi
