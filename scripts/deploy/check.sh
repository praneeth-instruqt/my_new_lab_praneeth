#!/bin/bash
url=$(gcloud run services describe hello --region us-central1 --format='value(status.url)' 2>/dev/null)
[ -n "$url" ] || exit 1
curl -fsS --max-time 20 -o /dev/null "$url"
