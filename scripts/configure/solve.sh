#!/bin/bash
set -e
gcloud config set project "$GOOGLE_CLOUD_PROJECT" --quiet
gcloud config set run/region us-central1 --quiet
