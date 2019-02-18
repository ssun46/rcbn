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

# Joinp peer0.org2.rgbproject.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051"
cli peer channel join -b channelrc.block
# Join peer1.org2.rgbproject.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051"
cli peer channel join -b channelrc.block
