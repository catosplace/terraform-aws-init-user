package test

import (
	"log"
	"regexp"
	"testing"
	"time"

	awsSDK "github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/service/organizations"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var oc *organizations.Organizations

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

	// Test the IAM User Policy
	session, _ := aws.CreateAwsSessionWithCreds("ap-southeast-2", accessKey,
		secretAccessKey)

	oc = organizations.New(session)
	checkPolicyApplied(t, oc)
	assertAllowOrgCreationInPolicy(t, oc)

}

func assertAllowOrgCreationInPolicy(t *testing.T,
	oc *organizations.Organizations) {

	logger.Log(t, "Asserting AllowOrgCreation in Policy.")

	createInput := &organizations.CreateOrganizationInput{
		FeatureSet: awsSDK.String("CONSOLIDATED_BILLING"),
	}

	org, err := oc.CreateOrganization(createInput)
  	if err != nil {
		log.Fatal(err)
	}	
	assert.Nilf(t, err, "Unable to Create Organization: %s", err)

	describeInput := &organizations.DescribeOrganizationInput{}
	_, err = oc.DescribeOrganization(describeInput)
	assert.Nilf(t, err, "Unable to Describe Organization: %s", err)

	// We don't test the Create Account at this time
	// but should look at how to do this in future iterations.

	listAccInputs := &organizations.ListAccountsInput{}
	_, err = oc.ListAccounts(listAccInputs)
	assert.Nilf(t, err, "Unable to List Org Accounts: %s", err)

	describeAccInput := &organizations.DescribeAccountInput{
		AccountId: awsSDK.String(*org.Organization.MasterAccountId),
	}
	_, err = oc.DescribeAccount(describeAccInput)
	assert.Nilf(t, err, "Unable to Describe Accounts: %s", err)

	// We don't test the Describe Create Account Status
	// at this time, as we are not creating accounts

	listRootsInput := &organizations.ListRootsInput{}
	_, err = oc.ListRoots(listRootsInput)
	assert.Nilf(t, err, "Unable to List Roots: %s", err)
	
	// We don't have the Delete Permission so we do this
	// using the main account in the make file.
	deleteInput := &organizations.DeleteOrganizationInput{}
	_, err = oc.DeleteOrganization(deleteInput)
	assert.NotNilf(t, err, "Able to Delete Organization", "")

}

func checkPolicyApplied(t *testing.T, oc *organizations.Organizations) {

	input := &organizations.DescribeOrganizationInput{}

	retry.DoWithRetry(t,
		"Checking IAM Policy Applied & In Use", 10, (500 * time.Millisecond),
		func() (string, error) {

			org, err := oc.DescribeOrganization(input)

			if err != nil {

				if aerr, ok := err.(awserr.Error); ok {

					switch aerr.Code() {

					case organizations.ErrCodeAWSOrganizationsNotInUseException:
						return "", nil

					default:
						return "", aerr
					}

				}

			}

			return *org.Organization.Id, nil
		})

}
