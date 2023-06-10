terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.5.0"
    }
    github = {
    source = "integrations/github"
    version = "5.26.0"
  }
    random = {
    source = "hashicorp/random"
    version = "3.5.1"
}
}
}

variable "org_service_url" {
	type = string
}

variable "personal_access_token" {
	type = string
}

variable "project_name" {
  type = string
}

provider "azuredevops" {
 
 org_service_url = var.org_service_url
 personal_access_token = var.personal_access_token

}

variable "gh_personal_access_token" {
	type = string
}

provider "github" {
  token = var.gh_personal_access_token
  }

provider "random" {

}
