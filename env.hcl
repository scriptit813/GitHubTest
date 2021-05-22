# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  rgname           = "rg-dev-sn3management"
  location         = "eastus"
  azurerm_version  = "~>2.41.0"
  ssh_path         = "~/.ssh/sn_config.pub"

  bastion_size          = "Standard_B2s"
  bastion_managementip  = [
    "88.152.184.205", 
    "52.227.175.189",
    "40.117.178.139"
    ]

}