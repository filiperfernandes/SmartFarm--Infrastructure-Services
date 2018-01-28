# Terraform google cloud multi tier deployment
# Author: Daniel Porto - daniel.porto@gmail.com

# check how configure the provider here:
# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
    # Create/Download your credentials from:
    # Google Console -> "APIs & services -> Credentials"
    # Choose create- > "service account key" -> compute engine service account -> JSON 
    credentials = "${file("terraform-credentials.json")}"
    project = "${var.GCP_PROJECT_NAME}"
    region = "${var.GCP_REGION}"
}
