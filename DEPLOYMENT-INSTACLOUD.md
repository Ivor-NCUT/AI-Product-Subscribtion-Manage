# Suspended-runtime preservation

This container preserves the application deployed from commit
`4fa5f0391b703132f95fa91d630b306cada03d35`. Application code is unchanged.
The server listens on port 8080 and uses only Node built-ins, so PM2 is not
required. The image copies application files explicitly and runs as `node`.

Build with `docker build -t nosam-manager .`. For local verification only,
run `docker run --rm -p 127.0.0.1:8080:8080 nosam-manager`.

The existing Zeabur project was suspended before this migration. The InstaCloud
service must use port `0` (no public HTTP endpoint), be verified with an internal
request to port 8080, and be stopped after acceptance. Do not attach a domain,
activate a public listener, or restart the source as part of preservation.

## Data and access behavior

- Users, subscriptions, products, and session state are stored in browser
  localStorage. There is no server database or persistent data volume.
- A new hostname does not inherit another origin's localStorage. This migration
  does not export, replace, or transfer users' browser data.
- Login and administrator checks are original client-side behavior, not
  server-enforced access control. The original `PASSWORD` environment variable
  is unused by `server.js`; do not describe it as protecting the service.
- Third-party JavaScript and CSS CDNs remain as in the original source.

If this application is later reactivated, separately resolve its public entry,
browser-data transfer, and server-side access control. Preserve the original
source configuration and Git commit for recovery; no source data is deleted.

## Acceptance

Use actual HTTP requests to check the three entry pages and all local scripts
they reference. Compare served file digests to the baseline. Exercise login
success/failure and subscription create/update/read/delete in an isolated
synthetic localStorage context; never use a real user's browser storage.
The existing `npm test` only prints a success message and is not evidence.
Finally read back both the target's stopped state and the source's suspended
state. The result is a verified paused runtime, not a production cutover.
