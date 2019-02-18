package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	"github.com/hyperledger/fabric/protos/peer"
)

type SmartContract struct {

}

// ----- Wallet ----- //
type Wallet struct {
	Balance	uint64 		`json:"balance"`// Balance
	TxInfo	Transaction	`json:"txInfo`	// Transaction Information
}

// ----- Transaction Information ----- //
type Transaction struct {
	Trader	string 	`json:"trader"`	// Collaborator
	Amount 	uint64 	`json:"amount"`	// Transaction amount
	Date 	string 	`json:"date"`	// Transaction date
	TxType 	string 	`json:"txType"`	// Transaction type
					// 		0: Publish(By Admin)
					// 		1: Payment(By Sender) 		2: Payment(By Receiver)
					// 		3: Cancel Payment(By Sender) 	4: Cancel Payment(By Receiver)	
					// 		5: Remittance(By Sender) 	6: Remittance(By Receiver)
					// 		7: Cancel Remittance(By Sender) 8: Cancel Remittance(By Receiver)	
}

// ============================================================================================================================
// 	Main
// ============================================================================================================================
func main() {
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}

// ============================================================================================================================
// 	Init
// ============================================================================================================================
func (s *SmartContract) Init(stub shim.ChaincodeStubInterface) peer.Response {
	return shim.Success(nil)
}

// ============================================================================================================================
// 	Invoke
//	init		:	invoke '{"Args":["init"]}'
//	get_account	:	query '{"Args":["get_account", "userId"]}'
//	get_txList	:	query '{"Args":["get_txList", "userId"]}'
// ============================================================================================================================
func (s *SmartContract) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	function, args := stub.GetFunctionAndParameters()

	if function == "init" {
		return s.Init(stub)
	} else if function == "get_account" {
		return get_account(stub, args)
	} else if function == "get_txList" {
		return get_txList(stub, args)
	}

	return shim.Error(fmt.Sprintf("Received unknown invoke function name: %s", function));
}

// ============================================================================================================================
// 	get_account
//	- params: userId
//	- return: Success(balance) / Error(strMsg)
// ============================================================================================================================
func get_account(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	var wallet Wallet
	
	if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	 }
  
	 walletAsBytes, _ := stub.GetState(args[0]);
	 if walletAsBytes == nil {
		return shim.Error(fmt.Sprintf("Could not locate Wallet '%s'", args[0]))
	 }

	 json.Unmarshal(walletAsBytes, &wallet)
	 balance := fmt.Sprint(wallet.Balance)

	 return shim.Success([]byte(balance))
}

// ============================================================================================================================
// 	get_txList
//	- params: userId
//	- return: Success([]txHistory) / Error(strMsg)
// ============================================================================================================================
func get_txList(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	type get_History struct {
		TxId    string   	`json:"txId"`
		Value 	Wallet   	`json:"value"`
	 }
	 var history []get_History;
	 var wallet Wallet
  
	 if len(args) != 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	 }
  
	 transferId := args[0]
	 fmt.Printf("- start getHistoryForMarble: %s\n", transferId)
  
	 resultsIterator, err := stub.GetHistoryForKey(transferId)
	 if err != nil {
		return shim.Error(err.Error())
	 }
	 defer resultsIterator.Close()
  
	 for resultsIterator.HasNext() {
		historyData, err := resultsIterator.Next()
		if err != nil {
		   return shim.Error(err.Error())
		}
  
		var tx get_History
		tx.TxId = historyData.TxId                     
		json.Unmarshal(historyData.Value, &wallet)    
		if historyData.Value == nil {                 
		   var emptyWalletHistory Wallet
		   tx.Value = emptyWalletHistory                
		} else {
		   json.Unmarshal(historyData.Value, &wallet) 
		   tx.Value = wallet                      
		}
		history = append(history, tx)   
	 }
	 
	 fmt.Printf("- getHistoryForMarble returning:\n%s", history)
  
	 historyAsBytes, _ := json.Marshal(history)     //convert to array of bytes
	 return shim.Success(historyAsBytes)  
}
