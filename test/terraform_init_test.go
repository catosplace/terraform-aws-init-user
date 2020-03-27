package test

import (
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformInitModule(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Check the IAM User created can do what our IAM Policy enables
	//userID := terraform.OutputRequired(t, terraformOptions, "user_id")

	// Check the IAM Access Keys were created and details returned
	accessKey := terraform.OutputRequired(t, terraformOptions, "user_access_key")
	secretAccessKey := terraform.OutputRequired(t, terraformOptions,
		"user_secret_access_key")

	assert.Regexp(t, regexp.MustCompile(`[A-Z0-9]{20}`), accessKey)
	assert.Regexp(t, regexp.MustCompile(`[A-Za-z0-9/+=]{40}`), secretAccessKey)
}
