# Introduction
Traders are able to gain exposure to crypto asset without taking custody of the underlying asset,by receiving cash settlement rather than the physical delievery.


# Contract Specification

## ETH Futures

| Underlying Asset  | ETH Index, provided by Market Protocol Oracle        | 
| -------------            |:-------------: | 
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Minimum Tick Size        |  0.01 ETH             |   
| Index Price Range        |   A Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Contract Size            |        1 ETH       |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         |Expirations are always at 08:00 UTC on Friday. Currently there are 2 weekly futures (collateraled in USDT and DAI). A new future with new expiry date will be added 1 hour after the expiration of the front future.         |
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |  The index price upon expiration, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](fees.md) for more details|   

