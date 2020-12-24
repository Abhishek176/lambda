data "archive_file" "main" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}


resource "aws_lambda_function" "example" {
   function_name = "ServerlessExample"

   filename = "main.zip"

   # "main" is the filename within the zip file (main.js) and "handler"
   # is the name of the property under which the handler function was
   # exported in that file.
   handler = "main.lambda_handler"
   runtime = "python3.8"

   role = aws_iam_role.lambda_exec.arn
}

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "lambda_exec" {
   name = "serverless_example_lambda"

   assume_role_policy = file("iam/lambda_asume_role.json")

}

resource "aws_iam_role_policy" "admin_access" {
  name = "admin_access"

  role = aws_iam_role.lambda_exec.id

  # TODO: Change resource to be more restrictive
  policy = file("iam/lamda_policy.json")
}
