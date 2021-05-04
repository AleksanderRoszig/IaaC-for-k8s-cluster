terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.38"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "kubernetesVPC"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnetkubernetes"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "kubernetesGW"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "kubernetesVPC_GW"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_network_interface" "networkinterfaceMaster" {
  subnet_id   = aws_subnet.main.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_network_interface" "networkinterfaceWorker" {
  subnet_id   = aws_subnet.main.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "masterNode" {
  ami           = "ami-03a53002ed02e1674"
  instance_type = "t2.medium"

  network_interface {
    network_interface_id = aws_network_interface.networkinterfaceMaster.id
    device_index         = 0
  }

  tags = {
    Name = "masterNode"
  }
}

resource "aws_instance" "workerNode" {
  ami           = "ami-03a53002ed02e1674"
  instance_type = "t2.medium"

  network_interface {
    network_interface_id = aws_network_interface.networkinterfaceWorker.id
    device_index         = 0
  }

  tags = {
    Name = "workerNode"
  }
}
