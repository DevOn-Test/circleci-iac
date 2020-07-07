terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "DevOn-Test"

    workspaces {
      name = "circleci-iac-test"
    }
  }
}
