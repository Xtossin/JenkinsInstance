#Provision a Jenkins Instance on ubuntu box.

resource "aws_instance" "jenkins-instance" {
  ami           = "${lookup(var.AMIS, var.AWS_region)}"
  instance_type = "t2.micro"
  key_name = "${var.MY_PRIVATE_KEY}"

  # the VPC subnet the instance will fall  into. See vpc.tf file for details
  subnet_id = "${aws_subnet.xtos-main-public-1.id}"

  # the security group the instance will belowng into. See securitygroup.tf
  vpc_security_group_ids = ["${aws_security_group.jenkins-securitygroup.id}"]


  # user data-This is used to execute data only at launch time.
  user_data = "${data.template_cloudinit_config.cloudinit-jenkins.rendered}"

}
#cat /var/lib/jenkins/secrets/initialAdminPassword
#the above is to get the initial jenkins password

#Spin up an EBS volume and mount. See jenkins-init.sh for details on script.
resource "aws_ebs_volume" "xtos-jenkins-data-box" {
    availability_zone = "us-west-1b"
    size = 20
    type = "gp2" 
    tags {
        Name = "Xtos-jenkins-data"
    }
}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id = "${aws_ebs_volume.xtos-jenkins-data-box.id}"
  instance_id = "${aws_instance.jenkins-instance.id}"
}
#The following is an instance that will be launched from a project in jenkins when i complete the script.
#setting the count = "${var.APP_INSTANCE_COUNT}" is by default 0(Terraform will skip creating this).
#Thus the AMI in not defined yet. Later will chnage this to 1 vars.tf- this is where i defined my variables.
resource "aws_instance" "app-instance" {
  count = "${var.APP_INSTANCE_COUNT}"
  ami = "${var.APP_INSTANCE_AMI}"
  instance_type = "t2.micro"
  key_name = "${var.MY_PRIVATE_KEY}"

  # the VPC subnet
  subnet_id = "${aws_subnet.xtos-main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.app-securitygroup.id}"]

}
