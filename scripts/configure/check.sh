#!/bin/bash
project=$(gcloud config get-value project 2>/dev/null)
region=$(gcloud config get-value run/region 2>/dev/null)

[ "$project" = "$GOOGLE_CLOUD_PROJECT" ] || exit 1
[ "$region" = "us-central1" ] || exit 1
