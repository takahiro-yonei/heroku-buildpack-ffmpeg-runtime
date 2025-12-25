#!/usr/bin/env bash
set -euo pipefail

FFMPEG_VERSION="${1:-n6.1.1}"   # 例: n6.1.1（タグ）
PREFIX="/opt/ffmpeg"

apt-get update
apt-get install -y --no-install-recommends \
  ca-certificates curl xz-utils pkg-config \
  build-essential yasm nasm

mkdir -p /work
cd /work

# ffmpeg公式のタグを取る（ミラーでもOK）
curl -fsSL "https://github.com/FFmpeg/FFmpeg/archive/refs/tags/${FFMPEG_VERSION}.tar.gz" | tar -xz
cd "FFmpeg-${FFMPEG_VERSION}"

./configure \
  --prefix="$PREFIX" \
  --disable-gpl \
  --disable-nonfree \
  --enable-shared \
  --disable-static \
  --disable-debug \
  --disable-doc \
  --disable-everything \
  --enable-ffmpeg \
  --enable-ffprobe \
  --enable-protocol=file \
  --enable-demuxer=mp3 \
  --enable-muxer=mp3 \
  --enable-muxer=null \
  --enable-parser=mpegaudio \
  --enable-decoder=mp3 \
  --enable-encoder=pcm_s16le \
  --enable-filter=silencedetect

make -j"$(nproc)"
make install

# 配布用に固める（bin/libを含む）
cd /opt
tar -czf /work/ffmpeg-runtime-heroku24-x86_64.tar.gz ffmpeg
sha256sum /work/ffmpeg-runtime-heroku24-x86_64.tar.gz > /work/ffmpeg-runtime-heroku24-x86_64.tar.gz.sha256
