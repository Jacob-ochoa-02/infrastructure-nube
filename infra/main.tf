provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Deshabilitar el bloqueo público para permitir acceso al sitio web
resource "aws_s3_bucket_public_access_block" "site_bucket" {
  bucket = aws_s3_bucket.site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Habilitar el hosting de sitio web estático
resource "aws_s3_bucket_website_configuration" "site_bucket" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html" # Angular maneja sus propias rutas (SPA)
  }
}

# Política pública de solo lectura para el sitio web
resource "aws_s3_bucket_policy" "site_bucket" {
  bucket = aws_s3_bucket.site_bucket.id

  # Esperar a que el bloqueo público esté deshabilitado antes de aplicar la política
  depends_on = [aws_s3_bucket_public_access_block.site_bucket]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.site_bucket.arn}/*"
      }
    ]
  })
}
