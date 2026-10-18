FROM node:24.15.0-bookworm-slim
WORKDIR /app
# The original server uses only Node built-ins. Keep PM2 and build tools out.
COPY --chown=node:node server.js *.html app*.js login-app.js ./
COPY --chown=node:node admin ./admin
COPY --chown=node:node components ./components
COPY --chown=node:node utils ./utils
COPY --chown=node:node assets ./assets
USER node
EXPOSE 8080
CMD ["node", "server.js"]
