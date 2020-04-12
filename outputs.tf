output name {
  value = var.name
}

output home {
  value = local.homedir
}

output key_name {
  value = aws_key_pair.this.key_name
}

output default_user {
  value = local.cloud_config_default_user
}

output user {
  value = local.cloud_config_user
}

output private_key {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output public_key {
  value = tls_private_key.this.public_key_openssh
}
