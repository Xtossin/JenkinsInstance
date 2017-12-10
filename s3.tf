
/*this will create an S3 to output/copy my terraform state from my local computer into an S3 bucket.
See configure-remote-state.*/
resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state-qwerty123456787q"
    acl = "private"

    tags {
        Name = "terraform-state-qwerty123456787q"
    }
}
