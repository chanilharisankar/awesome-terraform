resource "aws_security_group" "ec2_sg" {
  name_prefix = "${var.project_name}-${var.environment}-ec2-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting this to your IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[0]
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address  = true

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-instance"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = file(var.ssh_public_key_path)

  tags = {
    Name        = "${var.project_name}-${var.environment}-key"
    Environment = var.environment
    Project     = var.project_name
  }
}