variable "aws_region" {
    description = "The AWS region to deploy resources in main.tf"
    type        = string
    default     = "eu-west-2"
}

variable "instance_type" {
    description = "The EC2 instance type to use for the deployment"
    type        = string
    default     = "t3.micro"
}


