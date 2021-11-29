# Input variable definitions

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string

  validation {
    condition     = length(var.bucket_name) > 3 && length(var.bucket_name) <= 63
    error_message = "The bucket name must be between 3 and 63 characters long."
  }
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
