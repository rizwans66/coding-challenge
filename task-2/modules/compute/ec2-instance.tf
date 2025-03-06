resource "aws_instance" "node_todo" {
  ami                    = "ami-01ac7012b66081840"
  instance_type          = "t3.micro"
  key_name               = "linux-keypair-1"
  subnet_id              = var.subnet_id
  security_groups        = [var.security_group_id]
  user_data              = file("${path.module}/install.sh")

  tags = {
    Name = "Node-Todo-App"
  }
}
