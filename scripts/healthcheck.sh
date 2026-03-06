#!/usr/bin/env bash

PROCESS_NAME="${1:-bash}"
PORT_TO_CHECK="${2:-22}"

echo "=== Node Healthcheck Report ==="
echo

echo "[1/7] Hostname"
hostname
echo

echo "[2/7] User"
whoami
echo

echo "[3/7] Uptime"
uptime -p
echo

echo "[4/7] Memory"
free -h
echo

echo "[5/7] Disk"
df -h /
echo

echo "[6/7] Process Check: $PROCESS_NAME"
if ps aux | grep "$PROCESS_NAME" | grep -v grep >/dev/null; then
  echo "Process found: $PROCESS_NAME"
else
  echo "Process not found: $PROCESS_NAME"
fi
echo

echo "[7/7] Port Check: $PORT_TO_CHECK"
if ss -tuln | grep ":$PORT_TO_CHECK " >/dev/null; then
  echo "Port is listening: $PORT_TO_CHECK"
else
  echo "Port is not listening: $PORT_TO_CHECK"
fi
echo
