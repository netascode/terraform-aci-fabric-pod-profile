terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "POD1-2"
}

data "aci_rest" "fabricPodP" {
  dn = "uni/fabric/podprof-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "fabricPodP" {
  component = "fabricPodP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricPodP.content.name
    want        = module.main.name
  }
}
