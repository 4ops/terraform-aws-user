terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.50"
    tls = ">= 2.1"
  }
}

locals {
  homedir       = var.homedir != "" ? var.homedir : format("/home/%s", var.name)
  primary_group = var.primary_group != "" ? var.primary_group : var.name

  cloud_config_default_user = {
    name          = var.name
    gecos         = var.gecos
    groups        = var.groups
    lock_passwd   = var.lock_passwd
    shell         = var.shell
    home          = local.homedir
    ssh_import_id = [aws_key_pair.this.key_name]
  }

  cloud_config_user = {
    name                = var.name
    gecos               = var.gecos
    homedir             = local.homedir
    primary_group       = var.primary_group
    groups              = var.groups
    selinux_user        = var.selinux_user
    lock_passwd         = var.lock_passwd
    inactive            = var.inactive
    no_create_home      = var.no_create_home
    no_user_group       = var.no_user_group
    sudo                = var.sudo
    shell               = var.shell
    snapuser            = var.snapuser
    system              = var.system
    ssh_authorized_keys = compact(concat([tls_private_key.this.public_key_openssh], var.ssh_authorized_keys))
  }
}

resource tls_private_key this {
  algorithm   = var.algorithm
  rsa_bits    = var.rsa_bits
  ecdsa_curve = var.ecdsa_curve
}

resource aws_key_pair this {
  key_name   = var.key_name
  tags       = module.key_pair_tags.tags
  public_key = tls_private_key.this.public_key_openssh
}

module key_pair_tags {
  source  = "4ops/tags/null"
  version = "1.0.0"
  name    = var.key_name
  tags    = var.tags
}
