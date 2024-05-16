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
		TerraformDir: "../examples/basic",

		// Dynamic Variables that we should pass in addition to varfile.tfvars
		Vars: map[string]interface{}{
			"random_char": stringRand,
			"location":    "West US 2",
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualLoadBalancerIDs := terraform.Output(t, terraformOptions, "lb_id")

	assert.Equal(t, "/subscriptions/", actualLoadBalancerIDs[0:15])
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
