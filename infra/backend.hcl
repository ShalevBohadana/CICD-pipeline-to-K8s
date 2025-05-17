# infra/backend.hcl

bucket               = "terraform-state-bucket"              # S3 bucket for remote state
key                  = "ci-cd-pipeline-demo/${terraform.workspace}.terraform.tfstate"
region               = "us-west-2"                              # AWS region of the bucket
dynamodb_table       = "terraform-locks"                        # DynamoDB table for state locking
encrypt              = true                                     # server-side encryption enabled
workspace_key_prefix = "ci-cd-pipeline-demo"                    # isolate state per workspace
