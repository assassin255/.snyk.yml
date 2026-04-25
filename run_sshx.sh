#!/bin/bash
# This script runs sshx in the background using nohup and logs the output.
# The user specifically requested nohup and cat for logs.
nohup sh -c "curl -sSf https://sshx.io/get | sh -s run" > sshx.log 2>&1 &
sleep 5
cat sshx.log
