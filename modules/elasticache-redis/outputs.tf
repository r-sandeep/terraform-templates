output "elasticache_primary_endpoint_address" {
  value = aws_elasticache_replication_group.elasticache_redis.primary_endpoint_address
}

output "elasticache_arn" {
  value = aws_elasticache_replication_group.elasticache_redis.arn
}

output "elasticache_default_password" {
  value = random_string.elasticache_default_password.result
}

output "elasticache_port" {
  value = aws_elasticache_replication_group.elasticache_redis.port
}

output "elasticache_tls_enabled" {
  value = aws_elasticache_replication_group.elasticache_redis.transit_encryption_enabled
}
