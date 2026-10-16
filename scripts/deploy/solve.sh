#!/bin/bash
set -e
cd /root/app
gcloud run deploy hello --source . --region us-central1 --allow-unauthenticated --quiet
