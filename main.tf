provider "aws" {
    region = "ap-southeast-2"
    access_key = "AKIA3MPCOQ6U2NJOHS34"
    secret_key = "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"
}

variable "cidr_blocks" {
    description = "cidr blocks and name tags for vpc and subnets"
    type = list(object({
        cidr_block =  string
        name = string
    }))
}

resource "aws_vpc" "development-vpc" {
     cidr_block = var.cidr_blocks[0].cidr_block
     tags = {
        Name: var.cidr_block[0].name
     }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "ap-southeast-2a"
    tags = {
        Name: var.cidr_block[1].name
     }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}



