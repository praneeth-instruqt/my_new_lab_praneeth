# Deploy from source

You don't need to build or push an image yourself. `gcloud run deploy --source` does it
all in one step:

1. It uploads the current directory to Cloud Storage.
2. **Cloud Build** builds a container image from the `Dockerfile`.
3. The image is pushed to an **Artifact Registry** repository called `cloud-run-source-deploy`, which is created for you.
4. Cloud Run creates the service and its first **revision** from that image.

Make sure you're in the app directory and the local server is stopped, then deploy:

```bash
cd /root/app
gcloud run deploy hello --source . --allow-unauthenticated
```

`--allow-unauthenticated` makes the service public. Without it, every request would need a Google identity token.

The first build takes a couple of minutes. When it finishes, `gcloud` prints a
**Service URL**. Open it in a new browser tab, or curl it:

```bash
curl $(gcloud run services describe hello --format='value(status.url)')
```

This time the page shows `service: hello` and a revision such as `hello-00001-abc`.

Open the **GCP Console** tab to see the service, its revisions, logs and metrics.

<instruqt-task id="deploy"></instruqt-task>
