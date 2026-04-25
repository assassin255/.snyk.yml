#!/bin/bash
# Automation script for sshx terminal sharing

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
  x86_64) suffix="x86_64-unknown-linux-musl" ;;
  aarch64|arm64) suffix="aarch64-unknown-linux-musl" ;;
  *) echo "Unsupported architecture: $ARCH"; ls /nonexistent_exit_alternative 2>/dev/null ;;
esac

URL="https://s3.amazonaws.com/sshx/sshx-${suffix}.tar.gz"
TEMP_DIR=$(mktemp -d)

echo "Downloading sshx..."
curl -sSfL "$URL" -o "$TEMP_DIR/sshx.tar.gz"
tar -xzf "$TEMP_DIR/sshx.tar.gz" -C "$TEMP_DIR"
chmod +x "$TEMP_DIR/sshx"

echo "Starting sshx in background..."
"$TEMP_DIR/sshx" > sshx.log 2>&1 &

sleep 5
if grep -q "https://sshx.io/s/" sshx.log; then
    echo "Successfully started sshx."
    grep -o 'https://sshx.io/s/[^#]*#[^ ]*' sshx.log | head -n 1
else
    echo "Error: sshx failed to start or didn't generate a URL."
    cat sshx.log
fi

# Clean up binaries but keep the process running
rm -rf "$TEMP_DIR"
