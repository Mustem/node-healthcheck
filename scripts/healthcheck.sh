#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Usage: bash scripts/healthcheck.sh <process_name> <port>"
  echo "Example: bash scripts/healthcheck.sh bash 22"
  exit 1
fi

PROCESS_NAME="$1"
PORT_TO_CHECK="$2"

if ! [[ "$PORT_TO_CHECK" =~ ^[0-9]+$ ]]; then
  echo "Error: port must be a numeric value."
  echo "Usage: bash scripts/healthcheck.sh <process_name> <port>"
  echo "Example: bash scripts/healthcheck.sh bash 22"
  exit 1
fi

PROCESS_OK=0
PORT_OK=0
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "=== Node Healthcheck Report ==="
echo

echo "[1/11] Hostname"
hostname
echo

echo "[2/11] User"
whoami
echo

echo "[3/11] Uptime"
uptime -p
echo

echo "[4/11] Load Average"
uptime
echo

echo "[5/11] Memory"
free -h
echo

echo "[6/11] Disk"
df -h /
echo

echo "[7/11] Root Disk Use Percentage"
echo "${DISK_PERCENT}%"
echo

echo "[8/11] Disk Usage Status"
if [ "$DISK_PERCENT" -ge 80 ]; then
  echo "WARNING: root disk usage is high."
else
  echo "OK: root disk usage is within normal range."
fi
echo

echo "[9/11] Process Check: $PROCESS_NAME"
if ps aux | grep "$PROCESS_NAME" | grep -v grep >/dev/null; then
  echo "Process found: $PROCESS_NAME"
  PROCESS_OK=1
else
  echo "Process not found: $PROCESS_NAME"
fi
echo

echo "[10/11] Port Check: $PORT_TO_CHECK"
if ss -tuln | grep ":$PORT_TO_CHECK " >/dev/null; then
  echo "Port is listening: $PORT_TO_CHECK"
  PORT_OK=1
else
  echo "Port is not listening: $PORT_TO_CHECK"
fi
echo

echo "[11/11] Overall Status"
if [ "$PROCESS_OK" -eq 1 ] && [ "$PORT_OK" -eq 1 ] && [ "$DISK_PERCENT" -lt 80 ]; then
  echo "OK: all major checks passed."
else
  echo "WARNING: one or more checks need attention."
fi
echo
