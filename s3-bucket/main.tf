resource "aws_s3_bucket" "state" {
    provider = "aws.state"
    bucket = "${var.env_type}-${var.project_name}-tf-state"
    acl = "private"
    versioning {
        enabled = true
    }

replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
        id = "StateReplication"
        prefix = ""
        status = "Enabled"

        destination {
            bucket = aws_s3_bucket.backup.arn
            storage_class = "STANDARD"
        }
    }
}
}


resource "aws_s3_bucket" "backup" {
    provider = "aws.backup"
    bucket = "${var.env_type}-${var.project_name}-tf-state-backup"
    versioning {
        enabled = true
    }
}


resource "aws_dynamodb_table" "tf-state-lock" {
    provider = "aws.state"
    name = "${var.env_type}-${var.project_name}-tf-state-lock"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20
    attribute {
        name = "LockID"
        type = "S"
    }
}