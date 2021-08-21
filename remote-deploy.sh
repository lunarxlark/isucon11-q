#!/bin/bash

REPO_DIR=/home/isucon/isucon11-q

for server in 'i11-1' 'i11-2' 'i11-3'
do
  echo "### Start deploying for ${server}"
  ssh ${server} git -C ${REPO_DIR} pull origin main || echo "手動でprivate repoをcloneしてください"
  ssh ${server} bash ${REPO_DIR}/deploy.sh
done