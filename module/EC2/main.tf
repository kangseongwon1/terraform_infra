resource "aws_instance" "this" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids  = [var.security_group_id]
  availability_zone = var.availability_zone
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = var.key_name

  dynamic "root_block_device" {
    for_each = var.root_block_device

    content {
      delete_on_termination = try(root_block_device.value.delete_on_termination, null)
      encrypted             = try(root_block_device.value.encrypted, null)
      iops                  = try(root_block_device.value.iops, null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = try(root_block_device.value.volume_size, null)
      volume_type           = try(root_block_device.value.volume_type, null)
      throughput            = try(root_block_device.value.throughput, null)
      tags                  = try(root_block_device.value.tags, null)
    }
  }

  tags = merge({ "Name" = var.name }, var.instance_tags, var.tags)
}

