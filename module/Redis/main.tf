resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.replication_group_id
  description = var.description
  node_type = var.node_type
  port = var.port
  parameter_group_name = var.parameter_group_name
  automatic_failover_enabled = var.automatic_failover_enabled
  security_group_ids = var.security_group_ids
  multi_az_enabled = var.multi_az_enabled

  num_node_groups = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group
}
