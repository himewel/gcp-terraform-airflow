provider "google" {
  credentials = file(var.credentials_filepath)
  project = var.project_id
  zone = var.project_zone
}
