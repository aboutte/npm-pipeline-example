
# import requests
# def lambda_handler(event, context):   
#     r = requests.get('http://example.com/api')
#     return {
#         'statusCode': 200,
#         "body": "Success"
#     }p




# import boto3
# from botocore.exceptions import ClientError

# def get_secret(secret_name):
#     # Create a Secrets Manager client
#     client = boto3.client('secretsmanager')

#     try:
#         # Retrieve the secret value
#         response = client.get_secret_value(SecretId=secret_name)
#     except ClientError as e:
#         if e.response['Error']['Code'] == 'ResourceNotFoundException':
#             print("The requested secret " + secret_name + " was not found")
#         elif e.response['Error']['Code'] == 'InvalidRequestException':
#             print("The request was invalid due to:", e)
#         elif e.response['Error']['Code'] == 'InvalidParameterException':
#             print("The request had invalid params:", e)
#         else:
#             print("Unexpected error:", e)
#         return None
#     else:
#         # Parse and return the secret value
#         if 'SecretString' in response:
#             return response['SecretString']
#         else:
#             # For binary secrets, you need to decode the secret
#             return response['SecretBinary']

# # Example usage
# secret_name = 'your-secret-name'
# secret_value = get_secret(secret_name)
# if secret_value:
#     print("Secret value:", secret_value)