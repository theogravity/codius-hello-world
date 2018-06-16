#!/usr/bin/env bash

# Fail on first error
set -e

read -p "Your docker hub username: "  USERNAME

echo "Generating codius-manifest.json"

cp -f codius-manifest-template.json codius-manifest.json

# https://stackoverflow.com/questions/525592/find-and-replace-inside-a-text-file-from-a-bash-command
sed -i '' "s/{username}/${USERNAME}/" codius-manifest.json

echo "Publishing image to docker"
echo "Executing: 'docker push ${USERNAME}/codius-hello-world:latest'"

# On successful push, the last line contains the digest value
export IMG_ID=`docker push ${USERNAME}/codius-hello-world:latest | tail -1 | node extract-digest.js`

if [ -z "$IMG_ID" ]
then
    echo "Docker push either failed or is not returning the output we need to proceed (missing image digest)."
else
    echo "Stamping codius-manifest.json with the docker image hash"
    sed -i '' "s/{docker-id}/${IMG_ID}/" codius-manifest.json
    echo "codius-manifest.json generated"
fi
