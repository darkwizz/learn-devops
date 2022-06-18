# Azure Things
Different azure related things are going to be described here

## Azure CLI
How to upgrade installed azure CLI:
```bash
$ az upgrade
# if just running this command fails, then enable autoupgrade:
$ az config set auto-upgrade.enable=yes
```

To check the version:
```bash
$ az version
# OR 
$ az -v
```

### Working with subscriptions
When logging in subscriptions are listed as JSON
```bash
$ az login
>>> some JSON output...
```

To list available subscriptions:
```bash
$ az account list  # returns a JSON list
$ az account list -o yaml  # a YAML list
$ az account list -o table  # a table, the most compact format
```

Change the active subscription:
```bash
$ az account set -s {subscription ID, give}
```

### Working with resource groups
List groups:
```bash
$ az group list -o table  # just like with listing accounts, there are different formats
```

Set a default group:
```bash
$ az configure --defaults group={resource-group-name}
```

> all that can be executed to omit passing subscription and resource group for every `az command`

### Deploying from ARM templates
`az deployment group` - base command subgroup to manage deployments in a resource group. For the example below is used the template `./example-arm-templates/vnets.json` to create a virtual network. Prior to running the deployment command a default subscription and a resource group were set (using `az account set` and `az configure --defaults group`):
```bash
$ templateFile=./example-arm-templates/vnets.json
$ today=$(date +"%Y-%m-%d")
$ deploymentName="DeployLocalTemplate-$today"

$ az deployment group create --name $deploymentName --template-file $templateFile
```

To pass parameters in the command instead of using those specified in the ARM `.json`:
```bash
$ parameters="{\"vnetName\":{\"value\":\"VNet-001\"},\"costCenterIO\":{\"value\":\"54321\"},\"ownerName\":{\"value\":\"John Smith\"}}"
$ templateFile=./example-arm-templates/vnets.json
$ today=$(date +"%Y-%m-%d")
$ deploymentName="DeployLocalTemplate-$today"

$ az deployment group create --name $deploymentName --template-file $templateFile --parameters "$parameters"
```