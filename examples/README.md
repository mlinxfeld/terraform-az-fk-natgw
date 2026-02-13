# Azure NAT Gateway with Terraform / OpenTofu — Examples

This directory contains **hands-on Azure NAT Gateway examples** built around the
`terraform-az-fk-natgw` module.

The examples are designed as **progressive building blocks** that introduce how
Azure **NAT Gateway** works as a **dedicated outbound connectivity layer** for
private subnets and backend workloads.

These examples deliberately focus on **egress design patterns** and avoid
enterprise abstractions or platform shortcuts.

They are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across:

- Azure Fundamentals with Terraform / OpenTofu  
- Azure Networking & Security design notes  
- Backend architecture patterns (private workloads)  
- AKS and private cluster connectivity  
- Multicloud (Azure + OCI) architectural training  

---

## 🧭 Example Overview

| Example | Title | Key Topics |
|--------|-------|------------|
| 01 | **Private Subnet with NAT Gateway** | Outbound Internet access for private VMs, no public IPs, NAT Gateway attachment |
| 02 | **Private Backend with Load Balancer and NAT Gateway** | Public LB frontend, private backend tier, outbound egress via NAT Gateway |

Each example introduces **one clear outbound connectivity concept** and can be applied
**independently** for learning, experimentation, or reuse.

---

## ⚙️ How to Use

Each example directory contains:

- Terraform / OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the architectural goal
- Architecture diagrams and Azure Portal verification screenshots
- A **fully runnable deployment** (no placeholders, no mock resources)

To run an example:

```bash
cd examples/01_private_subnet_with_nat_gateway
tofu init
tofu plan
tofu apply
```

Examples may be deployed independently, but the **recommended learning path** is:

```
01 → 02
```

This mirrors real‑world Azure design:

- Start with a single private subnet that needs outbound Internet access
- Then evolve into a **public frontend + private backend tier** with NAT Gateway handling egress

---

## 🧩 Design Principles

These examples follow strict design rules:

- One example = one architectural concept  
- Explicit modeling of:
  - outbound connectivity paths  
  - NAT Gateway attachment to subnets  
  - public IP ownership for egress  
- Clear separation of concerns:
  - networking (VNet, subnet, NSG)  
  - outbound egress (NAT Gateway module)  
  - ingress traffic (Load Balancer module, where applicable)  
  - compute (VM module)  
- No hidden magic or implicit routing  
- All traffic paths are visible in Terraform  

The examples intentionally avoid:

- NAT instances or jumpbox patterns  
- Implicit outbound via public IP on VM  
- Platform landing zones  
- Kubernetes abstractions (covered in AKS modules)  

The goal is **clarity and correctness**, not completeness.

---

## 🔗 Related Modules & Training

- [terraform-az-fk-natgw](https://github.com/mlinxfeld/terraform-az-fk-natgw) (this repository)  
- [terraform-az-fk-vnet](https://github.com/mlinxfeld/terraform-az-fk-vnet)  
- [terraform-az-fk-nsg](https://github.com/mlinxfeld/terraform-az-fk-nsg)  
- [terraform-az-fk-loadbalancer](https://github.com/mlinxfeld/terraform-az-fk-loadbalancer)  
- [terraform-az-fk-compute](https://github.com/mlinxfeld/terraform-az-fk-compute)  
- [terraform-az-fk-aks](https://github.com/mlinxfeld/terraform-az-fk-aks)  

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See `LICENSE` for details.

---

© 2026 FoggyKitchen.com — Cloud. Code. Clarity.
