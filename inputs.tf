variable "name" {
  description = "Name of the NAT Gateway."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "create_public_ip" {
  description = "Whether to create a dedicated Public IP for the NAT Gateway."
  type        = bool
  default     = true
}

variable "public_ip_name" {
  description = "Optional name for the Public IP (when create_public_ip = true). Defaults to '<name>-pip'."
  type        = string
  default     = null
}

variable "public_ip_id" {
  description = "Existing Public IP ID to attach to the NAT Gateway (when create_public_ip = false)."
  type        = string
  default     = null
}

variable "public_ip_sku" {
  description = "SKU for the Public IP. NAT Gateway requires Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard"], var.public_ip_sku)
    error_message = "public_ip_sku must be 'Standard' for NAT Gateway."
  }
}

variable "public_ip_allocation_method" {
  description = "Allocation method for the Public IP. Standard must be Static."
  type        = string
  default     = "Static"

  validation {
    condition     = contains(["Static"], var.public_ip_allocation_method)
    error_message = "public_ip_allocation_method must be 'Static' for Standard Public IP."
  }
}

variable "idle_timeout_in_minutes" {
  description = "Idle timeout in minutes for NAT Gateway (4-120)."
  type        = number
  default     = 10

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 120
    error_message = "idle_timeout_in_minutes must be between 4 and 120."
  }
}

variable "subnet_associations" {
  description = "Map of subnet associations (NAT Gateway -> subnet). Keys must be static."
  type = map(object({
    subnet_id = string
  }))
  default = {}
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}

