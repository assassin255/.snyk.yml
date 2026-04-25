#!/bin/bash
# Detect architecture
ARCH=$(uname -m)
OS=$(uname -s)

URL="https://s3.amazonaws.com/sshx/sshx-x86_64-unknown-linux-musl.tar.gz"
TEMP_DIR=$(mktemp -d)

curl -sSfL "$URL" -o "$TEMP_DIR/sshx.tar.gz"
tar -xzf "$TEMP_DIR/sshx.tar.gz" -C "$TEMP_DIR"
chmod +x "$TEMP_DIR/sshx"

LOG_FILE=$(mktemp)
"$TEMP_DIR/sshx" > "$LOG_FILE" 2>&1 &
SSHX_PID=$!

sleep 5

if grep -q "https://sshx.io/s/" "$LOG_FILE"; then
    grep -o 'https://sshx.io/s/[^#]*#[^ ]*' "$LOG_FILE" | head -n 1
    echo "sshx is running with PID $SSHX_PID"
else
    echo "Error: Could not retrieve sshx URL."
    kill $SSHX_PID
fi

rm -rf "$TEMP_DIR"
