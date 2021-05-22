# Set common Tags for all resources
locals {
  core = {
    POC = "Micah Joiner"
    Department = "SOCEUR-J6x"
    Environment = "DEV"
  }

  resource_group = {
    SecPOC         = "SOCEUR-J6x"
    UpdateSchedule = "Daily-Security"
  }


  bastion_vm = {}
}
