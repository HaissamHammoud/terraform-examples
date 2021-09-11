/*
  Create cron event with cloudwatch
*/
resource "aws_cloudwatch_event_rule" "test-lambda" {
  name                  = "run-lambda-function"
  description           = "Schedule lambda function"
  schedule_expression   = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda-function-target" {
  target_id = "lambda-function-target"
  rule      = aws_cloudwatch_event_rule.test-lambda.name
  arn       = aws_lambda_function.test_lambda_function.arn
}