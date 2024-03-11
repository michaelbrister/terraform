module "my_vpc" {
  source = "../../modules/vpc"

  vpc_name            = "my-vpc"
  cidr                = "10.0.0.0/16"
  environment         = "dev"
  public_subnet_names = ["public_subnet_names"]
  public_subnets      = ["10.0.101.0/24"]

  private_subnets      = ["10.0.1.0/24"]
  private_subnet_names = ["my-private-subnet"]
}

resource "aws_iam_role" "dev_role" {
  name = "examplerole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dev_attachment" {
  role       = aws_iam_role.dev_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "dev_profile" {
  name = "dev_profile"
  role = aws_iam_role.dev_role.name
}

resource "aws_instance" "dev_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.my_vpc.public_subnets[0]
  vpc_security_group_ids      = module.my_vpc.security_grou_web.id
  associate_public_ip_address = true
  ebs_optimized               = true
  source_dest_check           = false
  key_name                    = default

  iam_instance_profile = aws_iam_instance_profile.dev_profile.name

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }

  # root disk
  root_block_device {
    volume_size           = "20"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "devinstance"
  }
}