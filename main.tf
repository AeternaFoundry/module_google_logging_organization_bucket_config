resource "google_logging_organization_bucket_config" "logging_organization_bucket_configs" {
  for_each = var.logging_organization_bucket_configs

  bucket_id       = each.value.bucket_id
  location        = each.value.location
  organization    = each.value.organization
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  retention_days  = each.value.retention_days

  dynamic "cmek_settings" {
    for_each = each.value.cmek_settings != null ? [each.value.cmek_settings] : []
    content {
      kms_key_name = cmek_settings.value.kms_key_name
    }
  }

  dynamic "index_configs" {
    for_each = each.value.index_configs != null ? each.value.index_configs : []
    content {
      field_path = index_configs.value.field_path
      type       = index_configs.value.type
    }
  }
}

