# MP Futures

## Introduction
MP Futures is a financial tool innovation.

Similarities with Futures:
- Has an expiration date
- With leverages

Differences from Futures:
- Each contract comes with a price cap and price floor. Any price goes beyond price cap or below price floor will be regarded price cap/price floor.
- Margin is fully collateralized, with no margin call.

## BTC Futures Contract Specifications

| Underlying Asset  | BTC Index, provided by Market Protocol Oracle         | 
| -------------            |:-------------: |
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Tick Size                | $0.1. minimum price movement |   
| Lot Size                 | 0.001 BTC. minimum order quantity movement |
| Index Price Range        |   A Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Contract Size            |      1 BTC         |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         |    Expirations are always at 15:00 UTC on Friday. A new futures contract with new expiry date will be added 1 hour after the expiration of the front futures contract.   |  
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |  The index price upon expiration, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](fees.md) for more details|   


## ETH Futures Contract Specifications

| Underlying Asset  | ETH Index, provided by Market Protocol Oracle        | 
| -------------            |:-------------: | 
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Tick Size                | $0.1. minimum price movement |   
| Lot Size                 | 0.1 ETH. minimum order quantity movement |
| Index Price Range        |   A Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Contract Size            |        1 ETH       |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         | Expirations are always at 15:00 UTC on Friday. A new futures contract with new expiry date will be added 1 hour after the expiration of the front futures contract.         |
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |  The index price upon expiration, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](fees.md) for more details|   


## TRUMP 2020 Contract Specifications

| Underlying Asset  | TRUMP Index, provided by Market Protocol Oracle. Refer to "What TRUMP expires to" in the attached for details     | 
| -------------            |:-------------: |
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Tick Size                | $0.001. minimum price movement |   
| Lot Size                 | 1 TRUMP. minimum order quantity movement |
| Index Price Range        | Cap price($1) and Floor price($0), TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise.        | 
| Contract Size            |      1 TRUMP         |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         |  2020-11-5 00:00:00 UTC  |    
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |   TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise.             | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee : refer to [fees](fees.md) for more details. <br>Market Protocol trading fee : Maker : 0.02%; Taker : 0.07%. |   


## Oracle

MP futures use Coincap as price feed.

## Architecture

![mai-arch](asset/mai-arch.png)
