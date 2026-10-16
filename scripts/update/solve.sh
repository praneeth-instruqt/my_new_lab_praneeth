#!/bin/bash
set -e
gcloud run services update hello --region us-central1 \
  --update-env-vars MESSAGE="Hello from revision two!" --quiet
