#!/usr/bin/env bash

PROCESS_NAME="${1:-bash}"
PORT_TO_CHECK="${2:-22}"

if ! [[ "$PORT_TO_CHECK" =~ ^[0-9]+$ ]]; then
  echo "Usage: bash scripts/healthcheck.sh <process_name> <port>"
  echo "Example: bash scripts/healthcheck.sh bash 22"
  exit 1
fi

PROCESS_OK=0
PORT_OK=0

echo "=== Node Healthcheck Report ==="
echo

echo "[1/10] Hostname"
hostname
echo

echo "[2/10] User"
whoami
echo

echo "[3/10] Uptime"
uptime -p
echo

echo "[4/10] Load Average"
uptime
echo

echo "[5/10] Memory"
free -h
echo

echo "[6/10] Disk"
df -h /
echo

echo "[7/10] Root Disk Use Percentage"
df -h / | awk 'NR==2 {print $5}'
echo

echo "[8/10] Process Check: $PROCESS_NAME"
if ps aux | grep "$PROCESS_NAME" | grep -v grep >/dev/null; then
  echo "Process found: $PROCESS_NAME"
  PROCESS_OK=1
else
  echo "Process not found: $PROCESS_NAME"
fi
echo

echo "[9/10] Port Check: $PORT_TO_CHECK"
if ss -tuln | grep ":$PORT_TO_CHECK " >/dev/null; then
  echo "Port is listening: $PORT_TO_CHECK"
  PORT_OK=1
else
  echo "Port is not listening: $PORT_TO_CHECK"
fi
echo

echo "[10/10] Overall Status"
if [ "$PROCESS_OK" -eq 1 ] && [ "$PORT_OK" -eq 1 ]; then
  echo "OK: process and port checks passed."
else
  echo "WARNING: one or more checks need attention."
fi
echo
