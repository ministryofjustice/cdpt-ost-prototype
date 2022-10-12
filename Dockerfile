FROM node:14.5.0-alpine

RUN apk add git bash

ARG UID=1001
RUN addgroup -g ${UID} -S appgroup && \
  adduser -u ${UID} -S appuser -G appgroup

WORKDIR /fb-runner-node/app

RUN chown appuser:appgroup /fb-runner-node/app

USER appuser

COPY --chown=appuser:appgroup fb-runner-node/package.json fb-runner-node/package-lock.json ./

ARG NPM_CMD='ci --ignore-optional --ignore-scripts'
RUN npm ${NPM_CMD}

COPY --chown=appuser:appgroup  . .
ENV SERVICE_PATH fb-housing-disrepair-prototype

EXPOSE 3000
CMD [ "node", "fb-runner-node/bin/start.js" ]
