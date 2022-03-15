package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAzureAKS(t *testing.T) {
	t.Parallel()
	// MC_+ResourceGroupName_ClusterName_AzureRegion must be no greater than 80 chars.
	// https://docs.microsoft.com/en-us/azure/aks/troubleshooting#what-naming-restrictions-are-enforced-for-aks-resources-and-parameters
	expectedClusterName := "AlphaCluster"
	expectedResourceGroupName := "Alpha"

	terraformOptions := &terraform.Options{
		TerraformDir: "../../azure-example/azure_aks",
		Vars: map[string]interface{}{
			"clustername": expectedClusterName,
			"rg-name":     expectedResourceGroupName,
		},
	}
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Look up the cluster node count
	cluster, err := azure.GetManagedClusterE(t, expectedResourceGroupName, expectedClusterName, "")
	require.NoError(t, err)
	actualCount := *(*cluster.ManagedClusterProperties.AgentPoolProfiles)[0].Count

	// Test that the Node count matches the Terraform specification
	assert.Equal(t, int32(1), actualCount)
}
