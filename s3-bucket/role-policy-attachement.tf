resource "aws_iam_role" "replication" {
   provider = "aws.state"
  name     = "terraform-iam-role-replica"

   assume_role_policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "s3.amazonaws.com"
        },
         "Effect": "Allow",
         "Sid": ""
         }
   ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
   provider = "aws.state"
   name = "terraform-iam-policy-replica"

   policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
         "Action":[
            "s3:GetReplicationConfiguration",
            "s3:ListBucket"
         ],
         "Effect":"Allow",
         "Resource":[
            "${aws_s3_bucket.state.arn}"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging"
         ],
         "Resource":[
            "${aws_s3_bucket.state.arn}/*"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags"
         ],
         "Resource" : "${aws_s3_bucket.backup.arn}/*"
      }
   ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
   provider = "aws.state"
   name = "terraform-iam-role-attachement-replica"
   roles = ["${aws_iam_role.replication.name}"]
   policy_arn = aws_iam_policy.replication.arn
}