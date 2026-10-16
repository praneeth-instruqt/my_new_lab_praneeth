#!/bin/bash
set -euo pipefail

# Flask for running the app locally.
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq python3-flask curl >/dev/null

gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS" --quiet

# Builds from `gcloud run deploy --source` run as the default compute service
# account, which has no roles in a fresh project. Give it what it needs.
PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format='value(projectNumber)')
COMPUTE_SA="${PROJECT_NUMBER}-compute@developer.gserviceaccount.com"
for role in roles/cloudbuild.builds.builder roles/run.builder; do
  gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member="serviceAccount:${COMPUTE_SA}" --role="$role" \
    --condition=None --quiet >/dev/null
done

# Start the learner with no project or region set; the first task does that.
gcloud config unset project --quiet || true
gcloud config unset run/region --quiet || true
