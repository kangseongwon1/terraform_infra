################################################################################
# DB Subnet Group
################################################################################

resource "aws_db_subnet_group" "this" {
  name = var.db_subnet_group_name
  description = "For Aurora cluster ${var.description}"
  subnet_ids = var.subnets

  tags = var.tags
}

resource "aws_rds_cluster" "this" {
  cluster_identifier = var.name
  engine_mode = var.engine_mode
  db_subnet_group_name = aws_db_subnet_group.this.name
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  engine = var.engine
  port = var.port
  skip_final_snapshot = var.skip_final_snapshot
  master_username = var.master_username
  master_password = var.master_password
  tags = merge(
    {"Name" = var.name} , var.tags
  )
}

################################################################################
# Cluster Parameter Group
################################################################################

resource "aws_rds_cluster_parameter_group" "this" {
  # count = var.create_db_cluster_parameter_group ? 1 : 0

  name        = var.db_cluster_parameter_group_name
  description = "Aurora cluster parameter group "
  family      = var.db_cluster_parameter_group_family

  dynamic "parameter" {
    for_each = var.db_cluster_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = try(parameter.value.apply_method, "immediate")
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}


resource "aws_db_parameter_group" "this" {
  name = var.db_parameter_group_name
  family = var.db_parameter_group_family

  dynamic parameter {
    for_each = [for s in var.parameter : {
        apply_method = s.apply_method
        name         = s.name
        value        = s.value
    }]
    content {
       apply_method = try(parameter.value.apply_method, "immediate")
       name = parameter.value.name
       value = parameter.value.value
    }
  }
  tags = merge(
    {"Name" = var.name} , var.tags
  )
}


resource "aws_rds_cluster_instance" "this" {
  for_each = { for k,v in var.instances : k => v }

  identifier =  var.name
  cluster_identifier = aws_rds_cluster.this.id

  instance_class = var.instance_class
  engine = var.cluster_instance_engine

  promotion_tier = var.promotion_tier
  publicly_accessible = var.publicly_accessible  
  tags = merge(
    {"Name" = var.name} , var.tags
  )

}