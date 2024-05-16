# Azure Terraform Modules

## Terraform Docs

The readme's in this folder are generated with [Terraform-Docs](https://github.com/terraform-docs/terraform-docs)

### Install

```
brew install terraform-docs
```

### Update

To update the readme just run:

```
terraform-docs markdown . > README.md
```

## Terratest
Each module has unit testing using Terratest associated with it.

### Starting a new test
In the modules directory, create a new folder named: `test`

```
mkdir test
cd test
```

Initilize the folder:
```
go mod init github.com/ManagedKube/kubernetes-ops
```


Create the Terratest file:

```
touch terratest_test.go
code terratest_test.go
```

Fill in the test details.  There are examples in this repo and the doc is here: https://github.com/gruntwork-io/terratest

### Running the test

In the `test` directory run:

```
go test -v
```

## Jenkins

Setting up Jenkins with Azure credentials: https://docs.microsoft.com/en-us/azure/developer/jenkins/deploy-to-azure-app-service-using-azure-cli#add-azure-service-principal-to-a-jenkins-credential

### Create a service principal

Doc: https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?toc=%252fazure%252fazure-resource-manager%252ftoc.json#create-a-service-principal

Doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

```
az ad sp create-for-rbac --role Contributor
```

Will produce:
```
{
  "appId": "00000000-0000-0000-0000-000000000000",  <-- CLIENT_ID
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",   <-- CLIENT_SECRET
  "tenant": "00000000-0000-0000-0000-000000000000"  <-- TENANT_ID
}
```

Possible to test the credentials:
```
$ az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID
```

