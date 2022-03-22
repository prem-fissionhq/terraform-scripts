variable "subnet_id" {
  description = "Public Subnet"
  default     = "subnet-cda0a8b5"
}

variable "vpc_id" {
  type    = string
  default = "vpc-a434dfcd"
}

resource "aws_security_group" "sg" {
  name   = "test12-kops-sg"
  vpc_id = var.vpc_id
  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "keyfile" {
  type    = string
  default = "pitta"
}

resource "aws_instance" "test12-kops" {
  iam_instance_profile   = "S3access"
  instance_type          = "t2.micro"
  ami                    = var.ubuntu_ami
  subnet_id              = var.subnet_id
  key_name               = var.keyfile
  vpc_security_group_ids = [aws_security_group.sg.id]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = "true"
  }

  #user_data = "${file("install_docker.sh")}"
  tags = {
    Name    = "test12-kops"
    Owner   = "prem"
    Purpose = "fission"
  }
}

resource "aws_instance" "test12-node" {
  iam_instance_profile   = "S3access"
  instance_type          = "t2.micro"
  ami                    = var.ubuntu_ami
  subnet_id              = var.subnet_id
  key_name               = var.keyfile
  vpc_security_group_ids = [aws_security_group.sg.id]

  #user_data              = "${file("install_kops.sh")}"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = "true"
  }

  tags = {
    Name    = "test12-node"
    Owner   = "prem"
    Purpose = "fission"
  }
}

