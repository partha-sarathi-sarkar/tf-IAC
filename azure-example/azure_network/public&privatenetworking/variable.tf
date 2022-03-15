variable "private_ip" {
  description = "The Static Private IP for the Internal NIC"
  type        = string
  default     = "10.0.20.5"
}

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "domain_name_label" {
  description = "The Domain Name Label for the Public IP Address"
  type        = string
}
