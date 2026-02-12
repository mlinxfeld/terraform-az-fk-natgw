output "nat_gateway_id" {
  description = "ID of the NAT Gateway."
  value       = azurerm_nat_gateway.this.id
}

output "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  value       = azurerm_nat_gateway.this.name
}

output "public_ip_id" {
  description = "ID of the Public IP associated with the NAT Gateway."
  value       = local.effective_public_ip_id
}

output "public_ip_address" {
  description = "Public IP address (only available when create_public_ip = true)."
  value       = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "subnet_association_ids" {
  description = "Map of subnet association resource IDs (NAT Gateway -> subnet)."
  value       = { for k, v in azurerm_subnet_nat_gateway_association.this : k => v.id }
}

