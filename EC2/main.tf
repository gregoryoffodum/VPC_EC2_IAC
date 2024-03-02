
locals {
  os = var.ami_maps[var.os_name]
}


resource "aws_instance" "web" {
  ami               = local.os
  availability_zone = var.availability_zone
  instance_type     = var.instance_type


  key_name = "<keyname>"
  tags = merge(var.common_tags, {
    "Name" = "WebServer"
  })
  vpc_security_group_ids = [aws_security_group.sgone.id]

  user_data = <<-EOF
        #!/bin/bash
         yum install nginx -y
         echo "<h1>Welcome to Terraform: $(hostname -I) </h1>" > /usr/share/nginx/html/index.html
         systemctl start nginx
  EOF

}

resource "aws_security_group" "sgone" {
  name        = "WebServer-SG"
  description = "Securtiy GP For WebServer. Allow HTTP & SSH Ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH Port"

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP Port"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow All Traffic all the destination."
  }
  tags = merge(var.common_tags, {
    "Name" = "WebServer-SG"
  })
}


