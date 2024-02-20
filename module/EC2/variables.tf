#  For EC2
variable "name" {
  description = "instance Name"
  type        = string
  default     = null
}

variable "key_name" {
  description = "Use pem key For ssh access instance"
  type        = string
  default     = null
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "instance Type"
  type        = string
  default     = null  
}

variable "availability_zone" {
  description = "availability_zone"
  type = string
  default = "null"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  
}

variable "instance_tags" {
  description = "Additional tags for the instance"
  type        = map(string)
  default     = {}   
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "security_group_id" {
  description = "access security_gruop"
}

# variable "security_group_id_private" {
#   description = "미구현"
# }

variable "root_block_device" {
  
}