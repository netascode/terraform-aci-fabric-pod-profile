<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-scaffolding/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-scaffolding/actions/workflows/test.yml)

# Terraform ACI Fabric Pod Profile Module

Manages ACI Fabric Pod Profile

Location in GUI:
`Fabric` » `Fabric Policies` » `Pods` » `Profiles`

## Examples

```hcl
module "aci_fabric_pod_profile" {
  source  = "netascode/fabric-pod-profile/aci"
  version = ">= 0.0.1"

  name = "POD1-2"
  selectors = [{
    name         = "SEL1"
    policy_group = "POD1-2"
    pod_blocks = [{
      name = "PB1"
      from = 1
      to   = 2
    }]
  }]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Fabric pod profile name. | `string` | n/a | yes |
| <a name="input_selectors"></a> [selectors](#input\_selectors) | List of selectors. Allowed values `from`: 1-255. Allowed values `to`: 1-255. | <pre>list(object({<br>    name         = string<br>    policy_group = optional(string)<br>    pod_blocks = list(object({<br>      name = string<br>      from = number<br>      to   = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `fabricPodP` object. |
| <a name="output_name"></a> [name](#output\_name) | Fabric pod profile name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fabricPodBlk](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fabricPodP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fabricPodS](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fabricRsPodPGrp](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->