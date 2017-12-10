#Security Group Resources

resource "aws_security_group" "jenkins-securitygroup" {
  vpc_id = "${aws_vpc.xtos-main.id}"
  name = "jenkins-securitygroup"
  description = "security group that allows ssh and all egress traffic"

#Outbound Rules.
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
#Inbound Rules. Currently ssh on port 22 is wide open. Restrict CIDR public to single IP range for more security.
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

tags {
    Name = "xtos-jenkins-securitygroup"
  }
}

#App instance SG:
resource "aws_security_group" "app-securitygroup" {
  vpc_id = "${aws_vpc.xtos-main.id}"
  name = "app-securitygroup"
  description = "security group that allows ssh and all egress traffic"

#Outbound Rules for App instance SG
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
#Inbound Rules for App insrance SG.Currently ssh on port 22 is wide open.
#Important: Restrict CIDR public to single IP range for more security.
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "xtos-app-securitygroup"
  }
}
