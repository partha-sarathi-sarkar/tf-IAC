package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAzureACR(t *testing.T) {
	t.Parallel()

	resourcegroupname := "resource"
	acrSKU := "Premium"

	// website::tag::1:: Configure Terraform setting up a path to Terraform code.
	terraformOptions := &terraform.Options{
		TerraformDir: "../../azure-example/azure_acr",
		Vars: map[string]interface{}{
			"rg-name": resourcegroupname,
			"sku":     acrSKU,
		},
	}

	// website::tag::5:: At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	acrName := terraform.Output(t, terraformOptions, "container_registry_name")
	loginServer := terraform.Output(t, terraformOptions, "login_server")

	// website::tag::4:: Assert
	assert.True(t, azure.ContainerRegistryExists(t, acrName, resourceGroupName, ""))

	actualACR := azure.GetContainerRegistry(t, acrName, resourceGroupName, "")

	assert.Equal(t, loginServer, *actualACR.LoginServer)
	assert.True(t, *actualACR.AdminUserEnabled)
	assert.Equal(t, acrSKU, string(actualACR.Sku.Name))
}
