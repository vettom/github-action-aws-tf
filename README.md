# github-action-aws-tf
Build Terraform workflow with Github action.

# Goals
[] AWS Open ID connect for token
[] Tf fmt and validate
[] Tflint
[] tfsec
[] Protect main branch
[] action on pull request only
[] Require approval for merge

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
    - Add 'Iam role Policy' allowing sts accume
    - Attach a policy that allow write to bucket

- Github
    - Create secret : AWS_BUCKET_NAME
    - Set tfstate file name AWS_BUCKER_KEY_NAME
    - Set region : AWS_REGION
    - Ser AWS role github action will assume : AWS_ROLE

# aws role template


```json
// Iam role policy
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::YOUR_ACCOUNT_NUMBER:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "repo:YOUR_GITHUB_USERNAME/YOUR_REPO_NAME:*"
                }
            }
        }
    ]
}
```

```json
// Policy/permission for s3 bucket write 
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