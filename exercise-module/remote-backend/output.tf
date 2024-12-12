output "bucketname" {
  value = aws_s3_bucket.s3_state
}

output "dynamodb_table" {
  value = aws_dynamodb_table.s3_locks
}