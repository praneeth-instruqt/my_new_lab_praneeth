#!/bin/bash
revisions=$(gcloud run revisions list --service hello --region us-central1 --format='value(name)' 2>/dev/null | wc -l)
[ "$revisions" -ge 2 ] || exit 1

url=$(gcloud run services describe hello --region us-central1 --format='value(status.url)')
body=$(curl -fsS --max-time 20 "$url") || exit 1
! grep -q "Hello from Cloud Run!" <<<"$body"
