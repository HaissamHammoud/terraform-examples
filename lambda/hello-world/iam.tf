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

// data "aws_iam_policy_document" "lambda_role_policy_document" {
//   statement {
//     effect = "Allow"

//     actions = [
//       "s3:Get*",
//       "s3:List*"
//     ]

//     resources = [
//       "*"
//     ]
//   }
// }

// resource "aws_iam_role_policy" "lambda_waf_policy" {
//   name = "lambda-waf-policy"
//   policy = data.aws_iam_policy_document.lambda_role_policy_document.json
//   role = aws_iam_role.lambda_role.id
// }