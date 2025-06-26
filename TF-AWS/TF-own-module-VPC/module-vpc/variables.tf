variable "vpc_config" {
  description = "Map of VPC configuration"
  type = object({
    cidr_block = string
    name       = string
  })
}
