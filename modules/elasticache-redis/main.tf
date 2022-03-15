resource "aws_kms_key" "elasticache_redis" {
  description         = "KMS key for ${var.clusterName} elasticache redis cluster"
  enable_key_rotation = true
  tags                = var.component_tags
}

resource "aws_kms_alias" "elasticache_redis" {
  name          = "alias/redis-${var.clusterName}-key"
  target_key_id = aws_kms_key.elasticache_redis.id
}

resource "random_string" "elasticache_default_password" {
  length  = 32
  special = false
}

resource "aws_elasticache_replication_group" "elasticache_redis" {
  apply_immediately             = true
  automatic_failover_enabled    = var.autoFailoverEnabled
  subnet_group_name             = var.elasticache_subnet_group_name
  security_group_ids            = [var.elasticache_sg_id]
  replication_group_id          = var.clusterName
  replication_group_description = "redis cache cluster"
  node_type                     = var.nodeType
  number_cache_clusters         = var.numNodes
  multi_az_enabled              = var.multiAZEnabled
  parameter_group_name          = var.parameteGroupName
  engine_version                = var.engineVersion
  snapshot_retention_limit      = 5
  port                          = 6379
  at_rest_encryption_enabled    = true
  kms_key_id                    = aws_kms_key.elasticache_redis.arn
  transit_encryption_enabled    = true
  auth_token                    = random_string.elasticache_default_password.result
  tags                          = var.component_tags
}

resource "vault_generic_secret" "elasticache_redis_password" {
  provider  = vault
  path      = var.vault_path
  data_json = <<EOF
{
  "REDIS_DB":"0",
  "REDIS_SOCKET_TYPE": "tcp",
  "REDIS_URL":"${format("%s:%d", aws_elasticache_replication_group.elasticache_redis.primary_endpoint_address, aws_elasticache_replication_group.elasticache_redis.port)}",
  "REDIS_AUTH":"${random_string.elasticache_default_password.result}",
  "REDIS_TLS": "${aws_elasticache_replication_group.elasticache_redis.transit_encryption_enabled}"
}
EOF
}
