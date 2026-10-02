#!/bin/bash
echo "=== $(date) ===" >> monitor.log
free -h >> monitor.log
df -h >> monitor.log
uptime >> monitor.log
echo "-----------------------------------" >> monitor.log
