# EC2 Instance without IAM Roles
resource "aws_instance" "t2-micro-inst" {
  # count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${data.aws_security_group.ssh.id}"]
  key_name               = aws_key_pair.key.key_name
  subnet_id              = data.aws_subnet.main-public-1.id
  #iam_instance_profile = "IAM"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 20 // 20GB
  }
  user_data = <<EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum -y install httpd.x86_64
    echo "Hello World from $(hostname -f)" > /var/www/html/index.html
    sudo systemctl enable httpd
    sudo systemctl start httpd
  EOF
  tags      = {
    Name = "m_associated_ec2.micro_instance"
  }

}

resource "aws_key_pair" "key" {
  key_name   = "key-pub"
  public_key = file("../.secret/key.pub")
}