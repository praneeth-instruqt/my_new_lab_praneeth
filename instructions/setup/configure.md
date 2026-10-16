# Configure gcloud

In this lab you'll take a small Python web app from source code to a public URL on
**Google Cloud Run**, a fully managed platform that runs containers and scales them
with traffic, down to zero when nobody is using them.

Your sandbox contains:

- A **Terminal** with the `gcloud` CLI, already signed in to a GCP project created just for you.
- An **App** tab that shows whatever is running on port `8080` in the terminal's machine.
- A **GCP Console** tab. It opens in a new window; sign in with the user from the **GCP Credentials** tab.

## Check your identity and project

Find out which account `gcloud` is using:

```bash
gcloud auth list
```

Your project ID is stored in the `GOOGLE_CLOUD_PROJECT` environment variable:

```bash
echo $GOOGLE_CLOUD_PROJECT
```

## Set the project and region

Tell `gcloud` to use that project by default:

```bash
gcloud config set project $GOOGLE_CLOUD_PROJECT
```

Cloud Run services are regional. Set `us-central1` as the default region so you don't
have to pass `--region` to every command:

```bash
gcloud config set run/region us-central1
```

Confirm both settings:

```bash
gcloud config list
```

<instruqt-task id="configure"></instruqt-task>
