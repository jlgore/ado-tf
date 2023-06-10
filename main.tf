resource "random_pet" "project_name" {
  keepers = {
  name = var.project_name
}
}

resource "azuredevops_project" "test-proj" {
	name = "gorecc-${random_pet.project_name.id}"
	description = "A test project"
	visibility = "private"
	version_control = "Git"
	work_item_template = "Agile"
}

resource "azuredevops_git_repository" "test-repo" {
	project_id = azuredevops_project.test-proj.id
	name = "Example Git Repo"
	default_branch = "refs/heads/main"
	initialization {
		init_type = "Clean"
	}
	}

data "github_user" "current" {
	username = "jlgore"
}

output "ssh_keys" {
	value = data.github_user.current.ssh_keys
}
