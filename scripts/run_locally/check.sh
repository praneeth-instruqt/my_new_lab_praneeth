#!/bin/bash
curl -fsS --max-time 5 http://localhost:8080/ | grep -q "<h1>"
