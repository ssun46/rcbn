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

# Install chaincode "invoke" into peer0.org2.rgbproject.com
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc_invoke -v 1.0 -p github.com/rc_chaincode/rc_invoke
# Install chaincode "query" into peer0.org2.rgbproject.com
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc_query -v 1.0 -p github.com/rc_chaincode/rc_query
# Install chaincode "invoke" into peer1.org2.rgbproject.com
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc_invoke -v 1.0 -p github.com/rc_chaincode/rc_invoke
# Install chaincode "query" into peer1.org2.rgbproject.com
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc_query -v 1.0 -p github.com/rc_chaincode/rc_query

# Install chaincode "rc_cc" into peer0.org2.rgbproject.com
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc -v 1.0 -p github.com/rc_chaincode/rc_cc
# Install chaincode "rc_cc" into peer1.org2.rgbproject.com
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer1.org2.rgbproject.com:7051" cli peer chaincode install -n rc_cc -v 1.0 -p github.com/rc_chaincode/rc_cc
