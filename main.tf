locals {
  pip_name = coalesce(var.public_ip_name, "${var.name}-pip")
}

# ---------------------------
# Public IP (optional)
# ---------------------------
resource "azurerm_public_ip" "this" {
  count               = var.create_public_ip ? 1 : 0
  name                = local.pip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = var.public_ip_allocation_method
  sku               = var.public_ip_sku

  tags = var.tags
}

# Decide which Public IP ID is used by NAT Gateway
locals {
  effective_public_ip_id = var.create_public_ip ? azurerm_public_ip.this[0].id : var.public_ip_id
}

# Validate that we have a Public IP ID in the final configuration
resource "null_resource" "validate_public_ip" {
  triggers = {
    effective_public_ip_id = local.effective_public_ip_id == null ? "null" : local.effective_public_ip_id
  }

  lifecycle {
    precondition {
      condition     = local.effective_public_ip_id != null
      error_message = "NAT Gateway requires a Public IP. Either set create_public_ip=true or provide public_ip_id."
    }
  }
}

# ---------------------------
# NAT Gateway
# ---------------------------
resource "azurerm_nat_gateway" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                = "Standard"
  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  tags = var.tags

  depends_on = [null_resource.validate_public_ip]
}

# Attach Public IP to NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = local.effective_public_ip_id
}

# ---------------------------
# Subnet associations
# ---------------------------
resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = var.subnet_associations

  subnet_id      = each.value.subnet_id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

