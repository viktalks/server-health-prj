#!/bin/bash

LOG_FILE="/var/log/sys_health.log"
THRESHOLD=80
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Create log directory if it doesn't exist
mkdir -p /var/log

# CPU Usage (user + system)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# Memory Usage
MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Disk Usage (root partition)
DISK=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

ALERT=0
ALERT_MSG=""

if (( $(echo "$CPU > $THRESHOLD" | bc -l) )); then
  ALERT=1
  ALERT_MSG+="High CPU usage: ${CPU}%\n"
fi

if (( $(echo "$MEM > $THRESHOLD" | bc -l) )); then
  ALERT=1
  ALERT_MSG+="High Memory usage: ${MEM}%\n"
fi

if (( $(echo "$DISK > $THRESHOLD" | bc -l) )); then
  ALERT=1
  ALERT_MSG+="High Disk usage: ${DISK}%\n"
fi

{
  echo "[$DATE] CPU: ${CPU}%, MEM: ${MEM}%, DISK: ${DISK}%"
  if [ $ALERT -eq 1 ]; then
    echo -e "ALERT:\n$ALERT_MSG"
  fi
} >> "$LOG_FILE"

# Auto-remove logs older than 7 days
find /var/log -name "sys_health.log.*" -mtime +7 -exec rm {} \;
