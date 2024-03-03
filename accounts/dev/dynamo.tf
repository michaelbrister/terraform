module "dynamo-lock-table" {
  source = "../../modules/dynamo-tf"

  dynmo_table_name = "my-tf-lock"
}