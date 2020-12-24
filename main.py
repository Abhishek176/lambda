import json
import boto3
from botocore.exceptions import ClientError

s3 = boto3.client('s3')
response = s3.list_buckets()
sns = boto3.client('sns')
message = {}
def lambda_handler(event, context):
    for bucket in response['Buckets']:
      try:
        enc = s3.get_bucket_encryption(Bucket=bucket['Name'])
        rules = enc['ServerSideEncryptionConfiguration']['Rules']
        message.update({bucket['Name']:rules})
      except ClientError as e:
        if e.response['Error']['Code'] == 'ServerSideEncryptionConfigurationNotFoundError':
          print('Bucket: %s, no server-side encryption' % (bucket['Name']))
        else:
          print("Bucket: %s, unexpected error: %s" % (bucket['Name'], e))
    sns.publish(
            TopicArn='arn:aws:sns:ap-south-1:214432655155:test',
            Message=json.dumps({'default': json.dumps(message)}),
            MessageStructure='json')
            
    return {
          'statusCode': 200,
          'body': json.dumps('Success')
      }