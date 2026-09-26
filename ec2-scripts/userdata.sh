#!/bin/bash
# Update system
dnf update -y

# Install web server
dnf install -y nginx

# Create our portfolio website
mkdir -p /var/www/html
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>My Portfolio - Monitoring Demo</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .metrics { background: #f5f5f5; padding: 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Harshal Portfolio Website</h1>
        <p>This is a demo site for AWS Monitoring System</p>
        
        <div class="metrics">
            <h3>System Metrics (Monitored by CloudWatch):</h3>
            <ul>
                <li>CPU Utilization</li>
                <li>Network Traffic</li>
                <li>Status Checks</li>
            </ul>
        </div>
        
        <h3>Load Generator:</h3>
        <button onclick="generateLoad()">Generate CPU Load (Trigger Alarm)</button>
        
        <script>
            function generateLoad() {
                fetch('/generate-load')
                .then(response => alert('CPU load generated! Check your email for alarm.'))
                .catch(err => alert('Load generation started'));
            }
        </script>
    </div>
</body>
</html>
EOF

# Create load generator endpoint
cat > /var/www/html/generate-load.sh << 'EOF'
#!/bin/bash
# Simple CPU stress test
timeout 30s openssl speed -multi $(nproc) > /dev/null 2>&1 &
echo "Load generation started"
EOF

chmod +x /var/www/html/generate-load.sh

# Configure nginx
systemctl start nginx
systemctl enable nginx

# Create a simple CGI endpoint for load generation
dnf install -y fcgiwrap
cat > /usr/share/nginx/html/generate-load << 'EOF'
#!/bin/bash
echo "Content-type: text/html"
echo ""
/var/www/html/generate-load.sh
echo "CPU load generated for 30 seconds!"
EOF

chmod +x /usr/share/nginx/html/generate-load

echo "Setup complete! Your instance is ready for monitoring."
EOF