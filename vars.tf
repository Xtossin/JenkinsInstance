#Empty Curly brackets means we are not specifying a value. An option is to specify a "default.
//Sensitive info is added in gitignore.


#variables for the access and Secret will be pulled from secret.tfvars or terraform.tfvars file(These are added in gtignore).
variable AWS_access_key{}
variable AWS_secret_key{}
variable "MY_PRIVATE_KEY"{}
variable "INSTANCE_USERNAME"{}

#Aws Region has a specified value of default to use.
variable "AWS_region" {
  default = "us-west-1"
}


#This variable is a map lookup for the AMI depending on the Variable AWS_region chosen.
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-8fd01af5"
    us-west-2 = "ami-65e7261d"
    us-west-1 = "ami-7f15271f"
    eu-west-1 = "ami-62cd101b"
  }
}





variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

#will install the following version of jenkins
variable "JENKINS_VERSION" {
  default = "2.32.1"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}
