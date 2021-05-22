# Infrastructure Build Process for SN3.0 
The Snet V3 Infrastructure build process uses a combination of [Terraform](https://www.terraform.io/) and [Terragrunt](https://terragrunt.gruntwork.io/) to be extensible as well as Easy to deploy

## Requirements
This build system requires Terraform as well as Terragrunt to deploy in order to by as [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) as possible

TODO: Make install script to local directory and execution
```
# Download Terraform
curl https://releases.hashicorp.com/terraform/0.14.8/terraform_0.14.8_darwin_amd64.zip -o terraform.zip
unzip terraform.zip
./terraform -version

# Download Terragrunt
curl -LsS https://github.com/gruntwork-io/terragrunt/releases/download/v0.28.15/terragrunt_darwin_amd64 -o terragrunt
chmod u+x terragrunt
./terragrunt -version
```

Ideally these two binaries are added to your path but it can be ran in an isolated environment. 

## Apply
```
./terragrunt run-all apply --terragrunt-tfpath $(pwd)/terraform
```
Do not run this at the top directory this command should only be ran in the specific directory you want to have built 
```
IE:
    /DEV
    /STAGE
    /PROD
```

## Cleanup
If you are doing development it is recommended to run the below command to clean local state as long as you are utilizing remote state otherwise you will need to run an init between all commands.

```
# Removes all terragrunt cache
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
```

When upgrading terraform versions it is required to run
```
find . -type f -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;
```

## Troubleshooting

Recieving Error that subscription does not exist.

Subscription list probably needs to be refreshed.
```
az account list --output table --refresh
```