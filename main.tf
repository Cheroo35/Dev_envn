# configure aws provider with credntial
provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_user" "userlist" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}

resource "aws_iam_group" "Developers-Group" {
  name = "Developers-Group"
}


resource "github_repository" "Dev_envn" {
  name        = "Dev_envn"
  description = "Code for server provisioning"

  visibility = "public"

}