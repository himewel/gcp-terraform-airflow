terraform {
  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
  required_version = ">= 0.14.3"
}
