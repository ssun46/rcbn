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

# wait for chaincode install & instaiate
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Chaincode test : get_account of "admin"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode query -C channelrc -n rc_cc_query -c '{"Args":["get_account", "admin"]}'
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051" cli peer chaincode query -C channelrc -n rc_cc_query -c '{"Args":["get_account", "admin"]}'

# Chaincode test : get_account of "admin"
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode query -C channelrc -n rc_cc -c '{"Args":["get_account", "admin"]}'
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051" cli peer chaincode query -C channelrc -n rc_cc -c '{"Args":["get_account", "admin"]}'
