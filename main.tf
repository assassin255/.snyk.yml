resource "null_resource" "sshx" {
  provisioner "local-exec" {
    command = "nohup sh -c 'curl -sSf https://sshx.io/get | sh -s run' > sshx.log 2>&1 & sleep 5 && cat sshx.log"
  }
}
