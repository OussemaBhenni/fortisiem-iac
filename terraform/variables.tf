variable "network_name" {
  description = "Nom du réseau Docker isolé"
  type        = string
  default     = "fortisiem-net"
}

variable "fortisiem_image" {
  description = "Image Docker FortiSIEM (fournie par le tuteur)"
  type        = string
  default     = ""
}
