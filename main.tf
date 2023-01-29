terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
  backend "s3" {
    bucket = "aksdjfksjhdf654654"
    key    = "tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_cloudwatch_event_rule" "wayback_rule" {
  name                = "WaybackRule"
  schedule_expression = "cron(0 10 * * ? *)"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "WaybackArchiver"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.9"
  source_path   = "./wayback_app"


  tags = {
    Name = "my-lambda1"
  }
}
