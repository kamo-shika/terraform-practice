variable "instance_type" {

}

resource "aws_security_group" "example_sg" {
  name = "example-sg"

  ingress = [
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      description      = "All HTTP inbound"
      self             = false
    },
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      description      = "All SSH inbound"
      self             = false
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      description      = "All outbound"
      self             = false
    }
  ]
}

data "aws_ssm_parameter" "AL2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64" # x86_64
}

resource "aws_instance" "default" {
  ami                    = data.aws_ssm_parameter.AL2023.value
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  instance_type          = var.instance_type
  user_data              = file("./http_server/user_data.sh")
  tags = {
    Name = "http-server"
  }
}

output "public_dns" {
  value = aws_instance.default.public_dns
}
