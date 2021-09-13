output "dn" {
  value       = aci_rest.fabricPodP.id
  description = "Distinguished name of `fabricPodP` object."
}

output "name" {
  value       = aci_rest.fabricPodP.content.name
  description = "Fabric pod profile name."
}
