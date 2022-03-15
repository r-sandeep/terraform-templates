variable "clusterName" {
  type = string
}

variable "private_subnet_ids" {
  type = list(any)
}

variable "elasticache_subnet_group_name" {
  type = string
}

variable "elasticache_sg_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "networkVPN" {
  type = string
}

variable "network_public_cidr_block" {
  type = string
}

variable "network_private_cidr_block" {
  type = string
}

variable "cellName" {
  type = string
}

variable "cellRegion" {
  type = string
}

variable "component_tags" {
  type = map(any)
}

variable "vault_path" {
  type = string
}

variable "nodeType" {
  type = string
  default = "cache.t4g.micro"
}

variable "multiAZEnabled" {
  type = bool
  default = true
}

variable "numNodes" {
  type = number
  description = "number cache clsuer nodes"
  default = 2
}

variable "autoFailoverEnabled" {
  type = bool
  default = true
}

variable "engineVersion" {
    type = string
    default = "6.x"
}

variable "parameteGroupName" {
  type = string
  default = "default.redis6.x"
}