
#this will output/cope my terraform state from my local computer into an S3 bucket.
resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state-qwerty123456787q"
    acl = "private"

    tags {
        Name = "terraform-state-qwerty123456787q"
    }
}
