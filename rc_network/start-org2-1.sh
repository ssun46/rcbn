#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

docker-compose -f docker-compose-org2.yml down

docker-compose -f docker-compose-org2.yml up -d peer0.org2.rgbproject.com peer1.org2.rgbproject.com couchdb2 couchdb3 cli
