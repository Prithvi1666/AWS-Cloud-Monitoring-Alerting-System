import boto3
import json

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event))
    
    # Initialize EC2 client
    ec2 = boto3.client('ec2')
    
    try:
        # Extract instance ID from CloudWatch alarm
        # Method 1: Try to get from alarm dimensions
        instance_id = None
        
        if 'alarmData' in event:
            # New CloudWatch alarm format
            metrics = event['alarmData']['configuration']['metrics']
            for metric in metrics:
                if 'metricStat' in metric and 'metric' in metric['metricStat']:
                    dimensions = metric['metricStat']['metric'].get('dimensions', {})
                    if 'InstanceId' in dimensions:
                        instance_id = dimensions['InstanceId']
                        break
        else:
            # Fallback: Try to get from trigger dimensions
            dimensions = event['detail']['configuration']['metrics'][0]['metricStat']['metric']['dimensions']
            instance_id = dimensions.get('InstanceId')
        
        if not instance_id:
            # If we can't find it in the event, use our specific instance
            # Replace with your actual instance ID from Phase 1
            instance_id = "i-xxxxxxxxxxxxx"  # We'll update this
            
        print(f"Attempting to reboot instance: {instance_id}")
        
        # Reboot the instance
        response = ec2.reboot_instances(InstanceIds=[instance_id])
        
        print(f"Successfully initiated reboot for instance: {instance_id}")
        print(f"Response: {response}")
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': f'Successfully initiated reboot for instance: {instance_id}',
                'instance_id': instance_id
            })
        }
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e),
                'message': 'Failed to reboot instance'
            })
        }