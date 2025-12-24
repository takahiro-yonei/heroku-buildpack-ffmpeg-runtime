#!/usr/bin/env bash

add_libdir () {
  if [ -d "$1" ]; then
    export LD_LIBRARY_PATH="$1:${LD_LIBRARY_PATH:-}"
  fi
}

BASE="$HOME/.apt/usr/lib/x86_64-linux-gnu"

add_libdir "$BASE/pulseaudio"
add_libdir "$BASE/blas"
add_libdir "$BASE/lapack"
