locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Load tags
  tag_lists = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  

  # Extract out common variables for reuse
  rgname = local.environment_vars.locals.rgname
  subscription_id = local.account_vars.locals.subscription_id
  ssh_path = local.environment_vars.locals.ssh_path
}

dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply", "destroy"]
  }
  source = "../../modules/linuxvm"

}

inputs = {
  resource_group_name = local.rgname
  
  vm_count         = 1

  vnet_name        = "vnet-snet3management"
  subnet_name      = "snet-management"

  sshpath          = local.ssh_path

  haspublic        = true

  vm_name          = "snet3-bastion"
  vm_size          = local.environment_vars.locals.bastion_size

  basic_tags  = local.tag_lists.locals.core

  vm_tags = merge(try(local.tag_lists.locals.bastion_vm, {}), local.tag_lists.locals.core)

  management_iplist = local.environment_vars.locals.bastion_managementip
  ansible_component = "bastion"
}

include {
  path = find_in_parent_folders()
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider azurerm {
  subscription_id = "${local.subscription_id}"
  features {}
  disable_terraform_partner_id = true
}
EOF
}
