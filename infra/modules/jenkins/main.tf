resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = concat(var.security_group_ids, [aws_security_group.jenkins.id])
  key_name               = var.key_name
  associate_public_ip_address = false  # Jenkins in private subnet
  iam_instance_profile       = var.iam_instance_profile

  user_data = <<-EOF
              #!/bin/bash
              amazon-linux-extras install java-openjdk11 -y
              yum install git docker -y
              service docker start
              usermod -a -G docker ec2-user
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              yum install jenkins -y
              systemctl enable jenkins
              systemctl start jenkins
              EOF

  tags = var.tags
}
