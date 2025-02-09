#!/bin/bash

LOG_DIR="/var/log/docker"
LOG_FILE="$LOG_DIR/monitoring.log"

# Create log directory if it doesn't exist
mkdir -p $LOG_DIR

# Create or clear the log file
> $LOG_FILE

while true; do
  # Write timestamp and container stats to log file
  echo "Timestamp: $(date)" >> $LOG_FILE
  echo "-----------------------------------------------------" >> $LOG_FILE
  for container in $(docker ps --format "{{.Names}}"); do
    echo "Container: $container" >> $LOG_FILE
    docker stats $container --no-stream --format "CPU: {{.CPUPerc}} | Memory: {{.MemUsage}}" >> $LOG_FILE
    echo "-----------------------------------------------------" >> $LOG_FILE
  done

  # Rotate log file
  find $LOG_DIR -name "monitoring.log*" -type f -mtime +7 -exec rm -f {} \;
  mv $LOG_FILE $LOG_FILE.$(date +%Y-%m-%d-%H%M%S)
  > $LOG_FILE

  # Sleep for 5 minutes (300 seconds)
  sleep 300
done
