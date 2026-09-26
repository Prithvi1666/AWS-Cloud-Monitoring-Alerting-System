# 🛡️ Monitoring and Alerting System (AWS Project)

This project demonstrates a cloud-native monitoring and alerting system using **AWS services** including CloudWatch, SNS, Lambda, and CloudTrail. It automatically monitors key AWS resources (EC2, RDS, ALB), generates alarms, sends notifications, and even performs automatic remediation actions.

## Architecture Diagram 
<img width="804" height="241" alt="image" src="https://github.com/user-attachments/assets/e9a06bb2-99fc-43e3-ad7f-1627ba87802a" />


## 🔧 Tools & Services Used

- **Amazon EC2** – Hosted a simple portfolio site
- **Amazon CloudWatch** – Monitoring and custom dashboards
- **Amazon SNS** – Email notifications
- **AWS Lambda** – Automatically restarts EC2 instance when alarm is triggered
- **AWS CloudTrail** – Logs user/API activity for auditing

## ✅ Features

- 📊 Monitor EC2, RDS, and ALB metrics
- 📈 Create custom CloudWatch dashboards
- 🚨 Set up CloudWatch Alarms to detect high CPU usage
- ✉️ Use SNS to send email notifications when alarms trigger
- 🤖 Lambda function automatically reboots the EC2 instance
- 🕵️ CloudTrail used to track all AWS activities

## 🧪 How It Works

1. **EC2 instance** is launched with a portfolio website hosted.
2. **CloudWatch Alarm** is created to monitor CPU utilization.
3. **SNS Topic** is subscribed to by email.
4. **Lambda function** is triggered by the alarm to reboot EC2.
5. **CloudTrail** records every action for compliance and auditing.

## Step-by-Step Flow
1. 🖥️ USER visits your website and clicks "Generate Load" button
   │
2. ⚡ EC2 server's CPU usage spikes to 80-90%
   │
3. 📊 CLOUDWATCH detects high CPU (like a doctor taking temperature)
   │
4. 🚨 CLOUDWATCH ALARM triggers (temperature is too high!)
   │
5. 📧 SNS immediately sends email: "ALERT: High CPU on your server!"
   │
6. 🤖 LAMBDA function automatically runs and reboots the server
   │
7. 📝 CLOUDTRAIL records everything for security
   │
8. ✅ Server comes back healthy - problem solved automatically!

