#!/bin/bash
cd /root/app
nohup python3 main.py >/tmp/app.log 2>&1 &
for _ in $(seq 1 20); do
  curl -fsS --max-time 2 http://localhost:8080/healthz >/dev/null && exit 0
  sleep 1
done
exit 1
