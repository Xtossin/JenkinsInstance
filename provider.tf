#The provider.tf file will contain alias variable for Provider(AWS in this case), Secrets and Region.


provider "aws" {
  access_key = "${var.AWS_access_key}"
  secret_key = "${var.AWS_secret_key}"
  region     = "${var.AWS_region}"
}