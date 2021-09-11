/*
  Create user role for lambda function
*/
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-lambdaRole-waf"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:Get*",
      "s3:List*"
    ]

    resources = [
      "*"
    ]
  }

    // statement{
    //     actions = [
    //         "apigateway:GET",
    //         "apigateway:SetWebACL",
    //         "cloudfront:ListDistributions",
    //         "cloudfront:ListDistributionsByWebACLId",
    //         "cloudfront:UpdateDistribution",
    //         "cloudwatch:GetMetricData",
    //         "cloudwatch:GetMetricStatistics",
    //         "cloudwatch:ListMetrics",
    //         "ec2:DescribeRegions",
    //         "elasticloadbalancing:DescribeLoadBalancers",
    //         "elasticloadbalancing:SetWebACL",
    //         "appsync:ListGraphqlApis",
    //         "appsync:SetWebACL",
    //         "waf-regional:*",
    //         "waf:*",
    //         "wafv2:*"
    //     ]
    //     effect = "Allow"
    //     resources =  ["*"]
    // }
}

resource "aws_iam_role_policy" "lambda_waf_policy" {
  name = "lambda-waf-policy"
  policy = data.aws_iam_policy_document.lambda_role_policy_document.json
  role = aws_iam_role.lambda_role.id
}

/* 
Arquive the script
*/
data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "nametest.zip"
}

/*
  Create the lamda function
*/
resource "aws_lambda_function" "test_lambda_function" {
    function_name = "lambdaTest"
    
    filename      = "nametest.zip"
    source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
    role          = aws_iam_role.lambda_role.arn
    runtime       = "python3.6"
    handler       = "lambda_function.lambda_handler"
    timeout       = 10
}