################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = try(aws_rds_cluster.this.arn, null)
}

output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = try(aws_rds_cluster.this.id, null)
}

output "cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = try(aws_rds_cluster.this.cluster_resource_id, null)
}

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = try(aws_rds_cluster.this.endpoint, null)
}

output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = try(aws_rds_cluster.this.reader_endpoint, null)
}

output "cluster_port" {
  description = "The database port"
  value       = try(aws_rds_cluster.this.port, null)
}

output "cluster_master_password" {
  description = "The database master password"
  value       = try(aws_rds_cluster.this.master_password, null)
  sensitive   = true
}

output "cluster_master_username" {
  description = "The database master username"
  value       = try(aws_rds_cluster.this.master_username, null)
  sensitive   = true
}

output "cluster_master_user_secret" {
  description = "The generated database master user secret when `manage_master_user_password` is set to `true`"
  value       = try(aws_rds_cluster.this.master_user_secret, null)
}

output "cluster_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = try(aws_rds_cluster.this.hosted_zone_id, null)
}

################################################################################
# Cluster Instance(s)
################################################################################

output "cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = aws_rds_cluster_instance.this
}

################################################################################
# Cluster Parameter Group
################################################################################

output "db_cluster_parameter_group_arn" {
  description = "The ARN of the DB cluster parameter group created"
  value       = try(aws_rds_cluster_parameter_group.this.arn, null)
}

output "db_cluster_parameter_group_id" {
  description = "The ID of the DB cluster parameter group created"
  value       = try(aws_rds_cluster_parameter_group.this.id, null)
}

################################################################################
# DB Parameter Group
################################################################################

output "db_parameter_group_arn" {
  description = "The ARN of the DB parameter group created"
  value       = try(aws_db_parameter_group.this.arn, null)
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group created"
  value       = try(aws_db_parameter_group.this.id, null)
}

