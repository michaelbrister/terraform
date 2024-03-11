resource "aws_iam_policy" "encrypted_s3_access" {
  name        = "encrypted_s3_access"
  description = "Allows access to encrypted S3 buckets and kms keys"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::storage-bucket",
          "arn:aws:s3:::storage-bucket/*"
        ]
      },
      {
        "Sid": "Allow an external account to use this KMS key",
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::444455556666:role/DevRole"
        },
        "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey""
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example.id
  policy = aws_iam_policy.encrypted_s3_access.policy
}

