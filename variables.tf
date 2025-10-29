variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_id" {
  description = "VPC ID to launch instances"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instances will be launched"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name to access EC2 instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0a91cd140a1fc148a" # Ubuntu 22.04 LTS
}

variable "instance_type" {
  description = "EC2 instance type for Kubernetes nodes"
  type        = string
  default     = "t3.medium"
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for Jenkins node"
  type        = string
  default     = "t3.large"
}

variable "k8s_node_count" {
  description = "Number of nodes for Kubernetes cluster"
  type        = number
  default     = 3
}

variable "k8s_volume_size" {
  description = "Disk size (GB) for each Kubernetes node"
  type        = number
  default     = 20
}

variable "jenkins_volume_size" {
  description = "Disk size (GB) for Jenkins node"
  type        = number
  default     = 20
}