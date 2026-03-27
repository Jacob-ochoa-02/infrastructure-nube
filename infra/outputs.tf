output "website_url" {
  description = "URL del sitio web estático en S3"
  value       = "http://${aws_s3_bucket_website_configuration.site_bucket.website_endpoint}"
}

output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.site_bucket.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.site_bucket.arn
}
