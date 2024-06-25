terraform {
  backend "s3" {
    bucket = "ecs-demo-tf" 
    key    = "django_test/terraform.tfstate" 
    region = "us-east-1"
  }
}
