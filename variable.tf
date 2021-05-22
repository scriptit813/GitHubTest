variable resource_group_name {
    type = string
}

variable location {
    type    = string
    default = "eastus"
}

variable rg_tags {
    type = map(string)
}
