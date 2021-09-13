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

data "aci_rest" "fabricPodS" {
  dn = "${data.aci_rest.fabricPodP.id}/pods-SEL1-typ-range"

  depends_on = [module.main]
}

resource "test_assertions" "fabricPodS" {
  component = "fabricPodS"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricPodS.content.name
    want        = "SEL1"
  }

  equal "type" {
    description = "type"
    got         = data.aci_rest.fabricPodS.content.type
    want        = "range"
  }
}

data "aci_rest" "fabricRsPodPGrp" {
  dn = "${data.aci_rest.fabricPodS.id}/rspodPGrp"

  depends_on = [module.main]
}

resource "test_assertions" "fabricRsPodPGrp" {
  component = "fabricRsPodPGrp"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.fabricRsPodPGrp.content.tDn
    want        = "uni/fabric/funcprof/podpgrp-POD1-2"
  }
}

data "aci_rest" "fabricPodBlk" {
  dn = "${data.aci_rest.fabricPodS.id}/podblk-PB1"

  depends_on = [module.main]
}

resource "test_assertions" "fabricPodBlk" {
  component = "fabricPodBlk"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricPodBlk.content.name
    want        = "PB1"
  }

  equal "from_" {
    description = "from_"
    got         = data.aci_rest.fabricPodBlk.content.from_
    want        = "1"
  }

  equal "to_" {
    description = "to_"
    got         = data.aci_rest.fabricPodBlk.content.to_
    want        = "2"
  }
}
