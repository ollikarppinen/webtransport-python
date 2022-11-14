#!/bin/bash
# INPUT_FILE_PATH=./media/source.mp4 . chunk.sh

ffmpeg \
    -y \
    -re \
    -stream_loop -1 \
    -i "$INPUT_FILE_PATH" \
    -c:v libx264 -crf 21 -preset veryfast -g 25 -sc_threshold 0 \
    -c:a aac -b:a 128k -ac 2 \
    -f hls -hls_time 4 -hls_list_size 3 -hls_flags independent_segments+delete_segments \
    stream.m3u8
