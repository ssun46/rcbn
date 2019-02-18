package main

import (
	"encoding/json"
	"fmt"
	"strconv"

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
//	publish		:	invoke '{"Args":["publish", "userId", "fromId", "amount", "date"]}'
// ============================================================================================================================
func (s *SmartContract) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	function, args := stub.GetFunctionAndParameters()

	if function == "init" {
		return s.Init(stub)
	} else if function == "publish" {
		return publish(stub, args)
	}

	return shim.Error(fmt.Sprintf("Received unknown invoke function name: %s", function));
}

// ============================================================================================================================
//	publish
//	- params: userId, fromId, amount, date
//	- return: Success(nil) / Error(strMsg)
// ============================================================================================================================
func publish(stub shim.ChaincodeStubInterface, args []string) peer.Response {
	var admin_for_history Wallet
	var target Wallet
	
	if len(args) != 4 {
		return shim.Error("Incorrect number of arguments. Expecting 4")
	}

	adminWalletAsBytes, _ := stub.GetState(args[1])
	walletAsBytes, _ := stub.GetState(args[0])
	if adminWalletAsBytes == nil {
		return shim.Error(fmt.Sprintf("Could not locate Wallet '%s'", "admin"))
	}	
	if walletAsBytes == nil {
		return shim.Error(fmt.Sprintf("Could not locate Wallet '%s'", args[0]))
	}
	
	json.Unmarshal(adminWalletAsBytes, &admin_for_history)
	json.Unmarshal(walletAsBytes, &target)
	amount, _ := strconv.ParseUint(args[2], 10, 64)
	
	admin_for_history.Balance += amount
	admin_for_history.TxInfo.Trader = args[0]
	admin_for_history.TxInfo.Amount = amount
	admin_for_history.TxInfo.TxType = "0"	// 0 is publish
	admin_for_history.TxInfo.Date = args[3]

	/////////////////////////////////////////////////////////////////////////////////
	// for get publish history
	target.Balance += amount
	target.TxInfo.Trader = args[1]
	target.TxInfo.Amount = amount
	target.TxInfo.TxType = "0"	// 0 is publish
	target.TxInfo.Date = args[3]
	/////////////////////////////////////////////////////////////////////////////////

	adminWalletAsBytes, _ = json.Marshal(admin_for_history)
	fail := stub.PutState(args[1], adminWalletAsBytes)
	if (fail != nil) {
		return shim.Error("Currency issue failed.");
	}

	walletAsBytes, _ = json.Marshal(target)
	err := stub.PutState(args[0], walletAsBytes)
	if (err != nil) {
		return shim.Error("Currency issue failed.");
	}

	return shim.Success(nil)
}
