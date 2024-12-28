
#!/bin/bash

# Define the log file
log_file="$HOME/system_health.log"

# Get the current date and time for logging
current_date=$(date +"%Y-%m-%d %H:%M:%S")

# Get the CPU usage (percentage)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Get the available memory (in percentage)
# This fetches the free memory and divides it by the total memory to calculate the available memory percentage.
available_mem=$(free | grep Mem | awk '{print $7/$2 * 100.0}')  # $7 is available memory, $2 is total memory

# Log header if log file doesn't exist
if [ ! -f "$log_file" ]; then
  echo "System Health Check Log - $(date)" > "$log_file"
  echo "========================================" >> "$log_file"
fi

# Log the CPU and memory usage
echo "$current_date - CPU Usage: $cpu_usage% - Available Memory: $available_mem%" >> "$log_file"

# Check if CPU usage is above 80% and log it
if (( $(echo "$cpu_usage > 80" | bc -l) )); then
  echo "$current_date - ALERT: CPU usage is above 80%! Current CPU usage: $cpu_usage%" >> "$log_file"
fi

# Check if available memory is below 20% and log it
if (( $(echo "$available_mem < 20" | bc -l) )); then
  echo "$current_date - ALERT: Available memory is below 20%! Current available memory: $available_mem%" >> "$log_file"
fi

# Print message to indicate script has finished
echo "System health check complete. Results logged to $log_file."
