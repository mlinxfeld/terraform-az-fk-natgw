# terraform-az-fk-natgw

This repository contains a reusable **Terraform / OpenTofu module** and progressive examples for deploying an **Azure NAT Gateway** and attaching it to **private subnets** to provide **controlled, predictable outbound connectivity** for private workloads.

It is part of the **FoggyKitchen.com training ecosystem** and is designed as a dedicated **egress boundary layer** for Azure workloads.

---

## 🎯 Purpose

The goal of this repository is to provide a **clear, educational, and composable reference implementation** for **Azure NAT Gateway** using Infrastructure as Code.

It focuses on:

- NAT Gateway as a **first-class egress boundary** in Azure networking
- Explicit modeling of:
  - outbound public IP ownership (Standard Public IP)
  - NAT Gateway resource
  - subnet associations (NAT Gateway → subnet)
- Clear separation between:
  - **inbound traffic entry** (Load Balancer / App Gateway)
  - **outbound connectivity identity** (NAT Gateway)
- Terraform/OpenTofu patterns that reflect **Azure’s real SNAT / outbound model**

This is **not** a landing zone, platform framework, or full network security stack.  
It is a **learning-first building block** designed to integrate cleanly with other FoggyKitchen modules.

---

## ✨ What the module does

Depending on configuration and example used, the module can:

- Create an **Azure NAT Gateway**
- Create and attach a **Standard Public IP** for outbound traffic
- Associate the NAT Gateway with one or more **subnets**
- Provide a **stable, auditable outbound IP identity** for private workloads
- Make outbound connectivity **explicit** (instead of “accidental” public IPs on NICs)

The module intentionally does **not** create or manage:

- Virtual Networks or subnets (handled by `terraform-az-fk-vnet`)
- Network Security Groups (handled by `terraform-az-fk-nsg`)
- Virtual Machines or VM Scale Sets (handled by `terraform-az-fk-compute`)
- Azure Bastion
- Azure Load Balancers (handled by `terraform-az-fk-loadbalancer`)
- Azure Firewall / NVAs
- Application Gateway / Front Door
- Private Endpoints (covered by dedicated modules/examples)

Each of those concerns belongs in its own dedicated module.

---

## 📂 Repository Structure

```bash
terraform-az-fk-natgw/
├── examples/
│   ├── 01_private_subnet_with_nat_gateway/
│   ├── 02_private_backend_with_public_lb_and_nat_gateway/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

---

## 🚀 Example Usage

### Attach NAT Gateway to a private subnet

```hcl
module "natgw" {
  source = "git::https://github.com/mlinxfeld/terraform-az-fk-natgw.git?ref=v1.0.0"

  name                = "fk-natgw"
  location            = "westeurope"
  resource_group_name = "fk-rg"

  public_ip = {
    name = "fk-natgw-pip"
  }

  subnet_associations = {
    private_subnet = {
      subnet_id = module.vnet.subnet_ids["fk-subnet-private"]
    }
  }

  tags = {
    project = "foggykitchen"
    env     = "dev"
  }
}
```

---

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `nat_gateway_id` | ID of the created NAT Gateway |
| `public_ip_id` | ID of the NAT Gateway public IP |
| `public_ip_address` | Public IP used for outbound SNAT |
| `subnet_association_ids` | IDs of subnet-NATGW association resources (if any) |
| `associated_subnet_ids` | Subnet IDs attached to the NAT Gateway |

---

## 🧠 Design Philosophy

- Outbound connectivity must be **explicit**
- Private workloads should not require **public IPs** on NICs
- Egress identity should be **stable and auditable** (allowlists, SaaS integrations, partner APIs)
- One module = one responsibility
- Inbound (LB/AppGW) and outbound (NATGW) paths are **separate architectural concerns**
- Avoid “magic SNAT” assumptions — model the traffic the way Azure actually routes it

This repository intentionally avoids abstractions that hide NAT Gateway mechanics behind “magic” defaults.

---

## 🧩 Related Modules & Training

- terraform-az-fk-vnet  
- terraform-az-fk-nsg  
- terraform-az-fk-loadbalancer  
- terraform-az-fk-compute  
- terraform-az-fk-storage  
- terraform-az-fk-aks  

Used across:

- **Azure Fundamentals with Terraform / OpenTofu**
- Private networking baselines (private subnets, controlled egress)
- Backend tier design patterns (LB ingress + NATGW egress)
- AKS networking foundations (egress patterns)

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com — Cloud. Code. Clarity.
