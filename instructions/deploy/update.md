# Ship a new revision

Revisions in Cloud Run are immutable. Every change to the code **or** the configuration
creates a new revision, and traffic moves to it once it's healthy.

## Change configuration, not code

Update the `MESSAGE` environment variable. Because no code changes, Cloud Run reuses the
existing image and the update finishes in seconds:

```bash
gcloud run services update hello --update-env-vars MESSAGE="Hello from revision two!"
```

Reload the service URL. You'll see the new message and a new revision name.

## Look at the revisions

```bash
gcloud run revisions list --service hello
```

Both revisions are listed, and 100% of traffic goes to the newest one. To roll back,
you'd send traffic to the old revision:

```bash
# Example only. Replace with your first revision's name.
# gcloud run services update-traffic hello --to-revisions hello-00001-abc=100
```

> [!NOTE]
> Leave the new revision serving traffic so the check below passes.

<instruqt-task id="update"></instruqt-task>

## Bonus

- Change the HTML in `main.py` and run `gcloud run deploy hello --source .` again. That's a code change, so it triggers a new build.
- Look at the build history with `gcloud builds list`.
