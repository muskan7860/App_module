#key pair(login)
resource "aws_key_pair" "my_app_key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("Terraform-key.pub")
}
#vpc and security group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
#security code
resource "aws_security_group" "my_security_group" {
    name = "${var.env}-infra-app-sg"
    description= "This will add TF generated security group"
    vpc_id = aws_default_vpc.default.id

  #inbound Rules
  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks=["0.0.0.0/0"]
    description= "ssh open"
  }
  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks=["0.0.0.0/0"]
    description="Http open"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description= "all access open outbound"
  }
  tags={
    Name="automate-sg-new"
  }
}
#ec2 instance
resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_app_key.key_name
    #security_groups = [aws_security_group.my_security_group.id]
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    instance_type = var.instance_type
    count = var.instance_count
    ami= var.ec2_ami_id
    user_data = file("install_nginx.sh")
    root_block_device {
      volume_size = var.env == "prod" ? 20 : 10
      volume_type = "gp3"
    }
    tags = {
      Name="${var.env}-infra-app-instance"
    }
  


}
        
