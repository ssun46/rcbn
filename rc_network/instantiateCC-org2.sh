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

# Instanticate chaincode "rc_cc_invoke"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" cli peer chaincode instantiate -o orderer.rgbproject.com:7050 -C channelrc -n rc_cc_invoke -v 1.0 -c '{"Args":["init"]}' -P 'AND ("Org1MSP.member", "Org2MSP.member")'
# Instanticate chaincode "rc_cc_query"
#docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" cli peer chaincode instantiate -o orderer.rgbproject.com:7050 -C channelrc -n rc_cc_query -v 1.0 -c '{"Args":["init"]}' -P 'OR ("Org1MSP.member", "Org2MSP.member")'

# Instanticate chaincode "rc_cc"
docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.rgbproject.com/users/Admin@org2.rgbproject.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.rgbproject.com:7051" cli peer chaincode instantiate -o orderer.rgbproject.com:7050 -C channelrc -n rc_cc -v 1.0 -c '{"Args":["init"]}' -P 'AND ("Org1MSP.member", "Org2MSP.member")'

printf "\nTotal execution time : $(($(date +%s) - starttime)) secs ...\n\n"
printf "\nStart with the registerAdmin.js, then registerUser.js, then server.js\n\n"
