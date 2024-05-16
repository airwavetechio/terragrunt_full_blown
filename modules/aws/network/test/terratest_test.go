package test

import (
	"math/rand"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Default test
func TestTerraformDefault(t *testing.T) {
	t.Parallel()

	// Random string for various dynamic bucket name usage
	stringRand := randomString(8)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Dynamic Variables that we should pass in addition to varfile.tfvars
		Vars: map[string]interface{}{
			"location":     "East US",
			"name_postfix": "unittest-az-vpc-" + stringRand,
			// "vpc_cidr":           "10.0.0.0/16",
			// "enable_nat_gateway": false,
			// "enable_vpn_gateway": false,
			"tags": `{
				ops_env              = "unit-test"
				ops_managed_by       = "terraform",
				ops_source_repo      = "deploy",
				ops_source_repo_path = "modules/azure/network",
				ops_owners           = "devops"
			  }`,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	outputResourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	outputVirtualNetworkName := terraform.Output(t, terraformOptions, "virtual_network_name")
	outputSubnetName := terraform.Output(t, terraformOptions, "subnet_name")
	outputSubnetId := terraform.Output(t, terraformOptions, "subnet_id")

	assert.Equal(t, "rg-unittest-az-vpc-"+stringRand, outputResourceGroupName)
	assert.Equal(t, "vnet-unittest-az-vpc-"+stringRand, outputVirtualNetworkName)
	assert.Equal(t, "subnet-unittest-az-vpc-"+stringRand, outputSubnetName)
	assert.Equal(t, "/subscriptions/", outputSubnetId[0:15])
}

func randomString(len int) string {

	rand.Seed(time.Now().UTC().UnixNano())
	bytes := make([]byte, len)

	for i := 0; i < len; i++ {
		bytes[i] = byte(randInt(97, 122))
	}

	return string(bytes)
}

func randInt(min int, max int) int {

	return min + rand.Intn(max-min)
}
