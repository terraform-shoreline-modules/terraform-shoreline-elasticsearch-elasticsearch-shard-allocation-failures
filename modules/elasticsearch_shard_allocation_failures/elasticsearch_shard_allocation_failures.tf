resource "shoreline_notebook" "elasticsearch_shard_allocation_failures" {
  name       = "elasticsearch_shard_allocation_failures"
  data       = file("${path.module}/data/elasticsearch_shard_allocation_failures.json")
  depends_on = [shoreline_action.invoke_elastic_config_update]
}

resource "shoreline_file" "elastic_config_update" {
  name             = "elastic_config_update"
  input_file       = "${path.module}/data/elastic_config_update.sh"
  md5              = filemd5("${path.module}/data/elastic_config_update.sh")
  description      = "Review the shard allocation settings and tune them appropriately."
  destination_path = "/tmp/elastic_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_elastic_config_update" {
  name        = "invoke_elastic_config_update"
  description = "Review the shard allocation settings and tune them appropriately."
  command     = "`chmod +x /tmp/elastic_config_update.sh && /tmp/elastic_config_update.sh`"
  params      = ["CLUSTER_NAME","INDEX_NAME"]
  file_deps   = ["elastic_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.elastic_config_update]
}

