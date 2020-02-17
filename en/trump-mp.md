# Introduction
Inspried by FTX, TRUMP 2020 is a futures contract on MCDEX.


# Contract Specification 

## TRUMP 2020 Futures

| Underlying Asset  | TRUMP Index, provided by Market Protocol Oracle.      | 
| -------------            |:-------------: |
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Tick Size                | $0.0001. minimum price movement |   
| Lot Size                 | 1 TRUMP. minimum order quantity movement |
| Index Price Range        | Cap price($1) and Floor price($0), TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise.        | 
| Contract Size            |      1 TRUMP         |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         |    Expirations are always at 15:00 UTC on Friday. A new futures contract with new expiry date will be added 1 hour after the expiration of the front futures contract.   |  
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |   TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise.             | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](fees.md) for more details|   



