module "natgw" {
  source = "../../" 

  name                = "fk-natgw"
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  create_public_ip = true

  subnet_associations = {
    private_subnet = {
      subnet_id = module.vnet.subnet_ids["fk-subnet-private"]
    }
  }

  tags = var.tags
}