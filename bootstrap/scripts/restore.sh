#!/usr/bin/env bash
#
# Restore the bootstrap snapshot.
#
# Only works if bootstrap-cache is in the default location
#
set -x
set -e

. ${BOOTSTRAP_REPOSITORY}/bootstrap/scripts/envvars.sh

pushd "${BOOTSTRAP_REPOSITORY}"
bootstrap/scripts/1-clean.sh
tar xzf "${BOOTSTRAP_REPOSITORY}/snapshot.tar.gz"
popd
