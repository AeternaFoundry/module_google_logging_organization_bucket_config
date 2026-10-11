variable "logging_organization_bucket_configs" {
  description = <<EOT
Map of logging_organization_bucket_configs, attributes below
Required:
    - bucket_id
    - location
    - organization
Optional:
    - deletion_policy
    - description
    - retention_days
    - cmek_settings (block):
        - kms_key_name (required)
    - index_configs (block):
        - field_path (required)
        - type (required)
EOT

  type = map(object({
    bucket_id       = string
    location        = string
    organization    = string
    deletion_policy = optional(string)
    description     = optional(string)
    retention_days  = optional(number)
    cmek_settings = optional(object({
      kms_key_name = string
    }))
    index_configs = optional(list(object({
      field_path = string
      type       = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.logging_organization_bucket_configs : (
        v.index_configs == null || (length(v.index_configs) <= 20)
      )
    ])
    error_message = "Each index_configs list must contain at most 20 items"
  }
}

