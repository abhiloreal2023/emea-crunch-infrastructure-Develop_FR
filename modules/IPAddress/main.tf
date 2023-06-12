variable "project" { type = string }
variable "env" { type = string }
variable "ssl" {type = bool}

provider "google" {
  version = "~> 4.31.0"
  project = var.project
}

# Create External IP Address
resource "google_compute_global_address" "crunch-webapp" {
  project      = var.project
  name         = "crunch-webapp"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

# Create Forwarding Rule
resource "google_compute_global_forwarding_rule" "crunch-webapp-frontend" {
  #provider   = google-beta
  project    = var.project
  count      = var.ssl ? 1 : 0
  name       = "crunch-webapp-frontend"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target     = google_compute_target_https_proxy.crunch-webapp-lb-target-proxy[0].self_link
  ip_address = google_compute_global_address.crunch-webapp.address
  port_range = "443"
}

# Create Target Proxy
resource "google_compute_target_https_proxy" "crunch-webapp-lb-target-proxy" {
  project = var.project
  count   = var.ssl ? 1 : 0
  name    = "crunch-webapp-lb-target-proxy"
  url_map = google_compute_url_map.crunch-webapp-lb[0].self_link

  ssl_certificates = tolist([google_compute_ssl_certificate.loreal-certificates[0].self_link]) 
  #ssl_policy       = var.ssl_policy  
}

#Create Certificate
resource "google_compute_ssl_certificate" "loreal-certificates" {
  project     = var.project
  count       = var.ssl ? 1 : 0
  name = "loreal-certificates"
  private_key = file("${path.module}/wildcard.loreal.net.key")
  certificate = file("${path.module}/wildcard.loreal.net.pem")

  lifecycle {
    create_before_destroy = true
  }
}

#Create URL Map
resource "google_compute_url_map" "crunch-webapp-lb" {
  project         = var.project
  count           = var.ssl ? 1 : 0
  name            = "crunch-webapp-lb"
  default_service = google_compute_backend_service.webapp-backend-angular[0].self_link
}

#Create Backend Service
resource "google_compute_backend_service" "webapp-backend-angular" {
  
  project = var.project
  count   = var.ssl ? 1 : 0
  name    = "webapp-backend-angular"  
  protocol    = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  locality_lb_policy    = "ROUND_ROBIN"
  connection_draining_timeout_sec = 0

  backend {
    group       = google_compute_region_network_endpoint_group.backend-service-angular[0].id
	}
}

#Create Backend Serverless Endpoint Group
resource "google_compute_region_network_endpoint_group" "backend-service-angular" {
  project = var.project
  count   = var.ssl ? 1 : 0
  name                  = "backend-service-angular"
  network_endpoint_type = "SERVERLESS"
  region                = "europe-west1"
  app_engine {
    service = "angular-app"
  }
}
