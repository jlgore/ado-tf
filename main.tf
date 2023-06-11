resource "random_pet" "project_name" {
  keepers = {
    name = var.project_name
  }
}

variable "project_name" {
  type    = string
  default = "tf"
}

variable "repo_name" {
  type    = string
  default = "Change This Repo Name!"
}

variable "project_description" {
  type    = string
  default = "A test project managed by Terraform"
}

resource "azuredevops_project" "proj" {
  name               = "${var.project_name}-${random_pet.project_name.id}"
  description        = var.project_description
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

resource "azuredevops_git_repository" "repo" {
  project_id     = azuredevops_project.proj.id
  name           = var.repo_name
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_git_repository_branch" "main" {
  repository_id = azuredevops_git_repository.repo.id
  name          = "main"
}

output "ssh_repo_url" {
  value = azuredevops_git_repository.repo.ssh_url
}

output "project_name" {
  value = azuredevops_project.proj.name
}
