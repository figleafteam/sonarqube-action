#!/bin/bash

set -e

if [[ "${GITHUB_EVENT_NAME}" == "pull_request" ]]; then
	EVENT_ACTION=$(jq -r ".action" "${GITHUB_EVENT_PATH}")
	if [[ "${EVENT_ACTION}" != "opened" ]]; then
		echo "No need to run analysis. It is already triggered by the push event."
		exit 78
	fi
fi

sonar-scanner \
  -Dsonar.projectKey=${INPUT_APP} \
  -Dsonar.sources=. \
  -Dsonar.host.url=${INPUT_HOST} \
  -Dsonar.projectBaseDir=${INPUT_PROJECTBASEDIR} \
  -Dsonar.sourceEncoding=UTF-8 \
  -Dsonar.login=${INPUT_LOGIN}

