resource "random_pet" "server_on_cloud" {
  length    = 3
  separator = "-"
}

output "cloud_server_name" {
  value = random_pet.server_on_cloud.id
}
