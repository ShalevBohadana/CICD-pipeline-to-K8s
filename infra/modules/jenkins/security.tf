resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg-${var.key_name}"
  description = "Allow SSH and HTTP to Jenkins"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH from your IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ssh_cidr]
  }

  ingress {
    description      = "Jenkins UI"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags
}
