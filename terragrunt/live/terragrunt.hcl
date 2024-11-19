locals {
  # root bucket for managing module state files
  bucket = "gcp-terragrunt-demo"

  # `project` and `location` are needed to create the bucket if it does not exist
  project = "buzzwatch-422510"
  location = "europe-west1-d"

  # this variable will be used by `parent` module to create a folder under an org
}

# creates GCS bucket for storing states
remote_state {
  backend = "gcs"

  config = {
    bucket = local.bucket
    prefix = "${path_relative_to_include()}/terraform.tfstate"
    project = local.project
    location = local.location
  }
}
