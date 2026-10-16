# Run the app locally

The app lives in `/root/app`, which is where your terminal starts:

```bash
ls -la
```

| File | Purpose |
| --- | --- |
| `main.py` | A Flask app that shows a message, plus the Cloud Run service and revision serving it |
| `requirements.txt` | Python dependencies: Flask, and gunicorn as the production server |
| `Dockerfile` | How Cloud Build packages the app into a container image |

Take a look at the app:

```bash
cat main.py
```

A few things to notice:

- The message comes from the `MESSAGE` environment variable, which you'll change later without editing code.
- The app listens on the port in `$PORT`. Cloud Run sets that for every container, and it defaults to `8080`.
- `K_SERVICE` and `K_REVISION` are set by Cloud Run, so locally they show as `local`.

## Start it

```bash
python3 main.py
```

Leave it running and open the **App (localhost:8080)** tab. You should see
**Hello from Cloud Run!** with service and revision both shown as `local`.

Click **Check** while the app is still running. Then press `Ctrl+C` in the terminal to stop it.

<instruqt-task id="run_locally"></instruqt-task>
