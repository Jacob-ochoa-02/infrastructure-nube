variable "bucket_name" {
    description     = "Nombre del bucket de s3 para el frontend"
    type            = string
}

variable "environment" {
    description     = "Ambiente de trabajo"
    type            = string
    default         = "dev"
}