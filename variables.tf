# --- Linux

variable name {
  default = "ec2-user"
}

variable gecos {
  default = "EC2 Default User"
}

variable primary_group {
  default = ""
}

variable groups {
  default = []
}

variable homedir {
  default = ""
}

variable lock_passwd {
  default = true
}

variable shell {
  default = "/bin/bash"
}

variable no_create_home {
  default = false
}

variable no_user_group {
  default = false
}

variable selinux_user {
  default = null
}

variable snapuser {
  default = null
}

variable inactive {
  default = false
}

variable system {
  default = false
}

variable sudo {
  default = ["ALL=(ALL) NOPASSWD:ALL"]
}

variable ssh_authorized_keys {
  default = []
}

# --- SSH key

variable algorithm {
  default = "RSA"
}

variable rsa_bits {
  default = "4096"
}

variable ecdsa_curve {
  default = "P384"
}

# --- AWS Key pair

variable key_name {
  default = "default-ec2-user"
}

variable tags {
  default = {
    Terraform = "true"
  }
}
