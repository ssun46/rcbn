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

docker-compose -f docker-compose-org1.yml down

docker-compose -f docker-compose-org1.yml up -d ca.rgbproject.com orderer.rgbproject.com peer0.org1.rgbproject.com peer1.org1.rgbproject.com couchdb0 couchdb1 cli

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=20
# echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
docker exec cli peer channel create -o orderer.rgbproject.com:7050 -c channelrc -f /opt/gopath/src/github.com/hyperledger/fabric/peer/configtx/channel.tx
# Joinp peer0.org1.rgbproject.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.rgbproject.com/users/Admin@org1.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org1.rgbproject.com:7051" cli peer channel join -b channelrc.block
# Join peer1.org1.rgbproject.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.rgbproject.com/users/Admin@org1.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org1.rgbproject.com:7051" cli peer channel join -b channelrc.block
