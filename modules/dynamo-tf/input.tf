variable "dynmo_table_name" {
  description = "DynamoDB lock table name"
  type        = string
  default     = "my-tf-lock"
}