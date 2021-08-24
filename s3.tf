resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForPublicWebsiteContent"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = {
                "AWS": "*"
            }
        Action    = "s3:GetObject"
        Resource = ["${aws_s3_bucket.this.arn}/*"]
      },
    ]
  })
}