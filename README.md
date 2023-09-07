# github-action-aws-tf
Build Terraform workflow with Github action.

# Goals
- [] AWS Open ID connect for token
- [] Tf fmt and validate
- [] Tflint
- [] tfsec
- [] Protect main branch
- [] action on pull request only
- [] Require approval for merge

# Steps

## S3 bucket to store statefile
- S3 bucket
    - Enable encryption
    - Enable bucker versioning

## IAM
- AWS Identity provider OpenID
    - in IAM create Identity provider
    - Select openID Connect
    - provider URL : token.actions.githubusercontent.com
    - Audience: sts.amazonaws.com
    - Get Thump print
- Custom Role
    - Create role with custom trust
    - add sts:AssumeRole



    1c58a3a8518e8759bf075b76b750d4f2df264fcd


# aws role template

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR_BUCKET/*",
                "arn:aws:s3:::YOUR_BUCKET"
            ]
        }
    ]
}

```

# Ref 
- https://cloudscalr.com/
- https://www.youtube.com/watch?v=GowFk_5Rx_I