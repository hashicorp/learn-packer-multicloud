#!/bin/bash

org_name="hashicorp-learn"

hcp_payload='{
  "data": {
    "type": "varsets",
    "attributes": {
      "name": "HCP Credentials",
      "description": "Variable sets with HCP service principal credentials",
      "global": true
    },
    "relationships": {
      "vars": {
        "data": [
          {
            "type": "vars",
            "attributes": {
              "key": "HCP_CLIENT_ID",
              "value": "'"$HCP_CLIENT_ID"'",
              "category": "env",
              "sensitive": true
            }
          },
          {
            "type": "vars",
            "attributes": {
              "key": "HCP_CLIENT_SECRET",
              "value": "'"$HCP_CLIENT_SECRET"'",
              "category": "env",
              "sensitive": true
            }
          }
        ]
      }
    }
  }
}'

aws_payload='{
  "data": {
    "type": "varsets",
    "attributes": {
      "name": "AWS Credentials",
      "description": "Variable sets with AWS credentials",
      "global": true
    },
    "relationships": {
      "vars": {
        "data": [
          {
            "type": "vars",
            "attributes": {
              "key": "AWS_ACCESS_KEY_ID",
              "value": "'"$AWS_ACCESS_KEY_ID"'",
              "category": "env",
              "sensitive": true
            }
          },
          {
            "type": "vars",
            "attributes": {
              "key": "AWS_SECRET_ACCESS_KEY",
              "value": "'"$AWS_SECRET_ACCESS_KEY"'",
              "category": "env",
              "sensitive": true
            }
          }
        ]
      }
    }
  }
}'

azure_payload='{
  "data": {
    "type": "varsets",
    "attributes": {
      "name": "Azure Credentials",
      "description": "Variable sets with Azure credentials",
      "global": true
    },
    "relationships": {
      "vars": {
        "data": [
          {
            "type": "vars",
            "attributes": {
              "key": "ARM_SUBSCRIPTION_ID",
              "value": "'"$ARM_SUBSCRIPTION_ID"'",
              "category": "env",
              "sensitive": true
            }
          },
          {
            "type": "vars",
            "attributes": {
              "key": "ARM_CLIENT_ID",
              "value": "'"$ARM_CLIENT_ID"'",
              "category": "env",
              "sensitive": true
            }
          },
          {
            "type": "vars",
            "attributes": {
              "key": "ARM_CLIENT_SECRET",
              "value": "'"$ARM_CLIENT_SECRET"'",
              "category": "env",
              "sensitive": true
            }
          },
          {
            "type": "vars",
            "attributes": {
              "key": "ARM_TENANT_ID",
              "value": "'"$ARM_TENANT_ID"'",
              "category": "env",
              "sensitive": true
            }
          }
        ]
      }
    }
  }
}'

# Create HCP variable set
echo "Creating HCP variable set..."
curl \
  --header "Authorization: Bearer $TFC_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data-raw "$hcp_payload" \
  https://app.terraform.io/api/v2/organizations/$org_name/varsets

echo -e "\nCreating AWS variable set..."
# Create AWS variable set
curl \
  --header "Authorization: Bearer $TFC_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data-raw "$aws_payload" \
  https://app.terraform.io/api/v2/organizations/$org_name/varsets

echo -e "\nCreating Azure variable set..."
# Create Azure variable set
curl \
  --header "Authorization: Bearer $TFC_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data-raw "$azure_payload" \
  https://app.terraform.io/api/v2/organizations/$org_name/varsets
