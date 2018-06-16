#!/usr/bin/env bash

# Fail on first error
set -e

# https://stackoverflow.com/questions/3349105/how-to-set-current-working-directory-to-the-directory-of-the-script
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

read -p "Your docker hub username: "  username

docker build -t ${username}/codius-hello-world .
