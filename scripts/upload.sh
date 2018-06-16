#!/usr/bin/env bash

# Fail on first error
set -e

read -p "Codius host URL: "  CODIUS_HOST

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

DEBUG=* codius upload codius-manifest.json --host ${CODIUS_HOST} --duration 200
