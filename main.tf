resource "random_pet" "project_name" {
  keepers = {
    name = var.project_name
  }
}

variable "project_name" {
  type    = string
  default = "tf"
}

resource "azuredevops_project" "proj" {
  name               = "gorecc-${random_pet.project_name.id}"
  description        = "A test project"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

resource "azuredevops_git_repository" "repo" {
  project_id     = azuredevops_project.proj.id
  name           = "Example Git Repo"
  default_branch = "refs/heads/main"
  initialization {
    init_type = "Clean"
  }
}

output "ssh_repo_url" {
  value = azuredevops_git_repository.repo.ssh_url
}
